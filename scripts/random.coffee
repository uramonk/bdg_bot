# Description:
#   The random commands show random boardgame registered in hubot.
#
# Commands:
#   hubot random - Show random boardgame
#   hubot random num #{player_num} - Show random boardgame which can be played by player_number

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
    random_index = Math.floor(Math.random() * boardgames.length)
    boardgame = []
    boardgame.push(boardgames[random_index])
    return boardgame
