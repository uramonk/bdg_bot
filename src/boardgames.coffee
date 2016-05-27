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

  getBoardgameListMessage: (boardgames) ->
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

  getParties: (robot) ->
    parties = storage.getParties(robot)
    parties.sort (a, b) ->
      if a.id < b.id
        -1
      else
        1
    return parties

  getPartyListMessage: (parties) ->
    parties_message = ''
    parties.map (item) ->
      id = item.id
      day = item.day
      time = item.time
      min = item.min
      max = item.max

      parties_message += "[#{id}] 開催日: #{day} #{time}\n"
    return parties_message
}
