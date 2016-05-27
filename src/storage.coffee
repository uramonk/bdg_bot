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

  getBoardgame: (robot, id) ->
    boardgame = null
    boardgames = this.getBoardgames(robot)
    boardgames.map (item) ->
      if item.id == id
        boardgame = item
    return boardgame

  updateBoardgame: (robot, boardgame) ->
    boardgames = this.getBoardgames(robot)
    new_boardgames = []
    boardgames.map (item) ->
      if item.id != boardgame.id
        new_boardgames.push(item)
      else
        new_boardgames.push(boardgame)
    robot.brain.set('boardgames', new_boardgames)
    robot.brain.save

  registParty: (robot, party) ->
    parties = this.getParties(robot)
    parties.push(party)
    robot.brain.set('parties', parties)
    robot.brain.save

  getParties: (robot) ->
    parties = robot.brain.get('parties') ? []
    return parties

  unregistParty: (robot, id) ->
    parties = this.getParties(robot)
    new_parties = []
    parties.map (item) ->
      if item.id != id
        new_parties.push(item)
    robot.brain.set('parties', new_parties)
    robot.brain.save

  getParty: (robot, id) ->
    party = null
    parties = this.getParties(robot)
    parties.map (item) ->
      if item.id == id
        party = item
    return party
}
