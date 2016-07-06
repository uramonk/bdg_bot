# Description:
#   The plan commands plans boardgame party.
#
# Commands:
#   hubot plan day #{yyyy/MM/DD} time #{hh:mm} min #{least_player_number}  max #{max_player_nunmber} - Plan boardgame party

storage = require('../src/storage')
{Promise} = require 'es6-promise'
_ = require 'lodash'

module.exports = (robot) ->
  postMessage = (msg, channelId) -> new Promise (resolve) ->
    robot.adapter.client._apiCall 'chat.postMessage',
      channel: channelId
      text: msg
      as_user: true
    , (res) -> resolve res

  addReaction = (name, channelId, ts) -> new Promise (resolve) ->
    robot.adapter.client._apiCall 'reactions.add',
      name: name
      timestamp: ts
      channel: channelId
    , (res) -> resolve res

  robot.respond /plan day (\d{4}\/\d{2}\/\d{2}) time (\d{2}:\d{2}) min (\d+) max (\d+)$/, (msg) ->
    day = msg.match[1]
    time = msg.match[2]
    min = msg.match[3]
    max = msg.match[4]

    parties = storage.getParties(robot)
    new_id = parties.length + 1

    parties.sort (a, b) ->
      if a.id < b.id
        -1
      else
        1
    .map (item) ->
      if item.id == new_id
        new_id += 1

    msg.send "#{day}の#{time}からボードゲーム会を開催します。\n
最小開催人数は#{min}人、最大人数は#{max}人までとなります。"

    channelId = robot.adapter.client.getChannelGroupOrDMByName(msg.envelope.room)?.id
    postMessage('参加可否をよろしくお願い致します。', channelId)
    .then (res) ->
      ['o', 'x'].reduce((curr, name) ->
        curr.then(-> addReaction(name, channelId, res.ts))
      , Promise.resolve())

      party = {
        'id': new_id,
        'day': day,
        'time': time,
        'min': min,
        'max': max,
        'timestamp': res.ts,
        'channelId': channelId,
        'participants': [
          msg.envelope.user.name
        ]
      }
      storage.registParty(robot, party)

  robot.adapter.client.on 'raw_message', (message) ->
    return if message.type isnt 'reaction_added' && message.type isnt 'reaction_removed'
    return if message.reaction isnt 'o'

    robotId = robot.adapter.client.getUserByName(robot.name).id
    return if message.user is robotId

    user = robot.adapter.client.getUserByID(message.user)
    parties = storage.getParties(robot)
    ts = message.item.ts
    channelId = message.item.channel
    party = null
    parties.map (item) ->
      if item.timestamp is ts && item.channelId is channelId
        party = item

    return if party == null

    if message.type is 'reaction_added'
      ms = "#{user.name}さんが参加しました。"
      postMessage(ms, message.item.channel)
      party.participants.push(user.name)
      storage.updateParty(robot, party)
    else if message.type is 'reaction_removed'
      ms = "#{user.name}さんがキャンセルしました。"
      postMessage(ms, message.item.channel)
      party.participants.pop(user.name)
      storage.updateParty(robot, party)
