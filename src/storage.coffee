module.exports = {
  registBoardgame: (robot, boardgame) ->
    # 保存されているボードゲーム配列を取得
    boardgames = this.getBoardgames(robot)

    # ボードゲームデータを保存
    boardgames.push(boardgame)
    robot.brain.set('boardgames', boardgames)
    robot.brain.save

  getBoardgames: (robot) ->
    boardgames = robot.brain.get('boardgames') ? []
    return boardgames

  unregisterBoardgame: (robot, id) ->
    boardgames = this.getBoardgames(robot)
    new_boardgames = []
    boardgames.map (item) ->
      if item.id != id
        new_boardgames.push(item)
    robot.brain.set('boardgames', new_boardgames)
    robot.brain.save
}
