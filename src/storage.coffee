module.exports = {
  registBoardgame: (robot, boardgame_name, min, max) ->
    # 保存されているボードゲーム配列を取得
    boardgames = robot.brain.get 'boardgames'
    if boardgames == null
      boardgames = []

    # 新たに登録するボードゲームデータを作成
    boardgame = {
      "id": boardgames.length + 1,
      "name": boardgame_name,
      "min": min,
      "max": max
    }

    # ボードゲームデータを保存
    boardgames.push(boardgame)
    robot.brain.set 'boardgames', boardgames
    robot.brain.save

  getBoardgames: (robot) ->
    boardgames = robot.brain.get 'boardgames'
    if boardgames == null
      boardgames = []
    return boardgames
}
