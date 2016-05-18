storage = require('./storage')

module.exports = {
  getBoardgames: (robot) ->
    boardgames = storage.getBoardgames(robot)
    boardgames.sort (a, b) ->
      if a.id < b.id
        -1
      else
        1
    return boardgames

  getBoardgamesByPlayerNum: (robot, player_num) ->
    boardgames = storage.getBoardgames(robot)
    new_boardgames = []
    boardgames.sort (a, b) ->
      if a.id < b.id
        -1
      else
        1
    .map (item) ->
      min = item.min
      max = item.max

      if min <= player_num && player_num <= max
        new_boardgames.push(item)

    return new_boardgames
}
