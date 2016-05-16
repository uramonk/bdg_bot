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
}
