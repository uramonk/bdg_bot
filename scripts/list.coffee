# Description:
#   The list commands show boardgames registered in hubot.
#
# Commands:
#   hubot list - Show boardgames registered
#   hubot list num #{player_num} - Show boardgames which can play it by player_number

bdg = require('../src/boardgames')

module.exports = (robot) ->
  robot.respond /list$/, (msg) ->
    boardgames = bdg.getBoardgames(robot)
    if boardgames.length == 0
      msg.send '登録されているボードゲームはありません。'
      return

    boardgames_message = getBoardgameListMessage(boardgames)
    msg.send '```\n' + boardgames_message + '```\n'

  robot.respond /list num (\d+)$/, (msg) ->
    player_num = Number(msg.match[1])

    boardgames = bdg.getBoardgamesByPlayerNum(robot, player_num)
    if boardgames.length == 0
      msg.send '登録されているボードゲームはありません。'
      return

    boardgames_message = getBoardgameListMessage(boardgames)
    if boardgames_message == ''
      msg.send "#{player_num}人でプレイ可能なボードゲームはありません。"
    else
      msg.send '```\n' + boardgames_message + '```\n'

  getBoardgameListMessage = (boardgames) ->
    boardgames_message = ''
    boardgames.map (item) ->
      id = item.id
      name = item.name
      min = item.min
      max = item.max

      if min == max
        boardgames_message += "#{id}: #{name}, プレイ人数: #{min}人\n"
      else
        boardgames_message += "#{id}: #{name}, プレイ人数: #{min}〜#{max}人\n"
    return boardgames_message
