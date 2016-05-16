# Description:
#   The list commands show boardgames registered in hubot.
#
# Commands:
#   hubot list - Show boardgames registered

storage = require('../src/storage')

module.exports = (robot) ->
  robot.respond /list$/, (msg) ->
    boardgames = storage.getBoardgames(robot)
    if boardgames.length == 0
      msg.send '登録されているボードゲームはありません。'
      return

    boardgame_list = ''
    for i in [0..boardgames.length]
      boardgame = boardgames[i]
      console.log(boardgame)

      id = boardgame.id
      console.log(id)
      name = boardgame.name
      min = boardgame.min
      max = boardgame.max

      if min == max
        boardgame_list += "#{id}: #{name}\n人数: #{min}人"
      else
        boardgame_list += "#{id}: #{name}\n人数: #{min}〜#{max}人"

    msg.send '```\n' + boardgame_list + '```\n'
