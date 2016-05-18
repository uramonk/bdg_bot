bdg = require('../src/boardgames')

module.exports = (robot) ->
  robot.respond /random$/, (msg) ->
    boardgames = bdg.getBoardgames(robot)
    boardgame = getRandomBoardgame(boardgames)
    message = bdg.getBoardgameListMessage(boardgame)
    msg.send '```\n' + message + '```\n'

  robot.respond /random num (\d+)$/, (msg) ->
    player_num = Number(msg.match[1])
    boardgames = bdg.getBoardgamesByPlayerNum(robot, player_num)
    boardgame = getRandomBoardgame(boardgames)
    message = bdg.getBoardgameListMessage(boardgame)
    msg.send '```\n' + message + '```\n'

  getRandomBoardgame = (boardgames) ->
    random_index = Math.floor(Math.random() * (boardgames.length - 1 + 1))
    boardgame = []
    boardgame.push(boardgames[random_index])
    return boardgame
