# Description:
#   The place commands show the venue for boardgame party.
#
# Commands:
#   hubot place|住所|場所 - Show the venue for boardgame party

module.exports = (robot) ->
  robot.respond /place|住所|場所$/, (msg) ->
    unless process.env.HUBOT_SLACK_BOARDGAME_PLACE
      msg.send '開催場所が登録されていません。'
      return
    msg.send "開催場所は#{process.env.HUBOT_SLACK_BOARDGAME_PLACE}です。"
