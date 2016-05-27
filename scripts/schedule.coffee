# Description:
#   The schedule commands show boardgame party schedule.
#
# Commands:
#   hubot schedule list - show boardgame party schedules

bdg = require('../src/boardgames')

module.exports = (robot) ->
  robot.respond /schedule list$/, (msg) ->
    parties = bdg.getParties(robot)
    if parties.length == 0
      msg.send 'ボードゲーム会の開催予定はありません。'
      return

    parties_message = bdg.getPartyListMessage(parties)
    msg.send '```\n' + parties_message + '```\n'
