# Description:
#   The list commands show boardgames registered in hubot.
#
# Commands:
#   hubot list - Show boardgames registered
#   hubot list num #{player_num} - Show boardgames which can play it by player_number

storage = require('../src/storage')

module.exports = (robot) ->
  robot.respond /list$/, (msg) ->
    boardgames = storage.getBoardgames(robot)
    if boardgames.length == 0
      msg.send '登録されているボードゲームはありません。'
      return

    boardgame_list = ''
    boardgames.sort (a, b) ->
      if a.id < b.id
        -1
      else
        1
    .map (item) ->
      id = item.id
      name = item.name
      min = item.min
      max = item.max

      if min == max
        boardgame_list += "#{id}: #{name}, プレイ人数: #{min}人\n"
      else
        boardgame_list += "#{id}: #{name}, プレイ人数: #{min}〜#{max}人\n"

    msg.send '```\n' + boardgame_list + '```\n'

  robot.respond /list num (\d+)$/, (msg) ->
    play_num = Number(msg.match[1])

    boardgames = storage.getBoardgames(robot)
    if boardgames.length == 0
      msg.send '登録されているボードゲームはありません。'
      return

    boardgame_list = ''
    boardgames.sort (a, b) ->
      if a.id < b.id
        -1
      else
        1
    .map (item) ->
      id = item.id
      name = item.name
      min = item.min
      max = item.max

      if min <= play_num && play_num <= max
        if min == max
          boardgame_list += "#{id}: #{name}, プレイ人数: #{min}人\n"
        else
          boardgame_list += "#{id}: #{name}, プレイ人数: #{min}〜#{max}人\n"

    if boardgame_list == ''
      msg.send "#{play_num}人でプレイ可能なボードゲームはありません。"
    else
      msg.send '```\n' + boardgame_list + '```\n'
