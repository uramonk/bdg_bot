# Description:
#   The plan commands plans boardgame party.
#
# Commands:
#   hubot plan day #{yyyy/MM/DD} time #{hh:mm} min #{least_player_number}  max #{max_player_nunmber} - Plan boardgame party

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
