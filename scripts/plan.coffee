# Description:
#   The plan commands plans boardgame party.
#
# Commands:
#   hubot plan day #{yyyy/MM/DD} time #{hh:mm} min #{least_player_number}  max #{max_player_nunmber} - Plan boardgame party

_ = require 'lodash'
storage = require('../src/storage')

module.exports = (robot) ->
  robot.respond /plan day (\d{4}\/\d{2}\/\d{2}) time (\d{2}:\d{2}) min (\d+) max (\d+)$/, (msg) ->
    day = msg.match[1]
    time = msg.match[2]
    min = msg.match[3]
    max = msg.match[4]

    msg.send "#{day}の#{time}からボードゲーム会を開催します。\n
最小開催人数は#{min}人、最大人数は#{max}人までとなります。\n
参加可否をよろしくお願い致します。"

  robot.hear /.*ボードゲーム会を開催します。\n最小開催人数は.*までとなります。\n参加可否をよろしくお願い致します。&/, (msg) ->
    unless _.contains ['bdg_bot'], msg.envelope.user.name
      msg.finish()
    addVoteReactions(msg, 'o')
    addVoteReactions(msg, 'x')

  addVoteReactions = (msg, reaction) ->
    options = {
      'token': process.env.HUBOT_SLACK_TOKEN,
      'name': reaction,
      'channel': msg.message.rawMessage.channel
      'timestamp': msg.message.rawMessage.ts
    }
    msg.http('https://slack.com/api/reactions.add')
      .query(options)
      .post() (err, res, body) ->
        console.log('post')
        return
