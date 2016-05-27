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

    msg.send "#{day}の#{time}からボードゲーム会を開催します。\n
最小開催人数は#{min}人、最大人数は#{max}人までとなります。"

    channelId = robot.adapter.client.getChannelGroupOrDMByName(msg.envelope.room)?.id
    postMessage('参加可否をよろしくお願い致します。', channelId)
    .then (res) ->
      ['o', 'x'].reduce((curr, name) ->
        curr.then(-> addReaction(name, channelId, res.ts))
      , Promise.resolve())
