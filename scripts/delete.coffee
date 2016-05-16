storage = require('../src/storage')

module.exports = (robot) ->
  robot.respond /delete (\d+)$/, (msg) ->
    id = Number(msg.match[1])
    storage.unregisterBoardgame(robot, id)
    boardgames = storage.getBoardgames(robot)
