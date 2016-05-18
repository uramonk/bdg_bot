# Description:
#   The update commands update boardgame registered in hubot.
#
# Commands:
#   hubot update #{id} name #{new_boardgame_name} min #{new_min_number} max #{new_max_number} - Update boardgame which id is #{id}

storage = require('../src/storage')

module.exports = (robot) ->
  robot.respond /update (\d+) name (.*) min (\d+) max (\d+)$/, (msg) ->
    id = Number(msg.match[1])
    name = msg.match[2]
    min = Number(msg.match[3])
    max = Number(msg.match[4])

    boardgame = storage.getBoardgame(robot, id)
    if boardgame == null
      msg.send "IDが#{id}のボードゲームはありません。"
      return

    boardgame = {
      'id': id,
      'name': name,
      'min': min,
      'max': max
    }
    storage.updateBoardgame(robot, boardgame)
