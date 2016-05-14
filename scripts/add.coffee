module.exports = (robot) ->
  robot.respond /add (.*) min (\d+) max (\d+)$/, (msg) ->
    boardgame_name = msg.match[1]
    min = Number(msg.match[2])
    max = Number(msg.match[3])

    if min <= 0 || max <= 0
      msg.send '1以上の数を入力してください。'
      return

    if min > max
      msg.send '最小人数が最大人数よりも大きいです。'
      return

    # ToDo: Redisに保存する処理

    if min == max
      msg.send '「' + boardgame_name + '」を登録しました。¥nプレイ人数：' + min + '人'
    else
      msg.send '「' + boardgame_name + '」を登録しました。¥nプレイ人数：'
      + min + '〜' + max + '人'

  robot.respond /add (.*) num (\d+)$/, (msg) ->
    boardgame_name = msg.match[1]
    num = Number(msg.match[2])

    if num <= 0
      msg.send '1以上の数を入力してください。'
      return

    # ToDo: Redisに保存する処理

    msg.send '「' + boardgame_name + '」を登録しました。¥nプレイ人数：' + num + '人'
