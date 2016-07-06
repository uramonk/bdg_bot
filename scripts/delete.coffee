# Description:
#   The delete commands delete boardgame registered in hubot.
#
# Commands:
#   hubot delete #{id} - Delete boardgame registered

storage = require('../src/storage')

module.exports = (robot) ->
  robot.respond /delete (\d+)$/, (msg) ->
    id = Number(msg.match[1])
    storage.unregisterBoardgame(robot, id)
    boardgames = storage.getBoardgames(robot)
