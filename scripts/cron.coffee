# Description
#   This file defines cron operations.

require('date-utils')
CronJob = require('cron').CronJob
storage = require('../src/storage')

module.exports = (robot) ->
  weekJob = new CronJob(
    cronTime: '00 00 00 * * *'
    onTick: ->
      checkParties()
      return
    start: true
  )

  checkParties = () ->
    parties = storage.getParties(robot)
    date = Date.today()
    parties.map (item) ->
      itemDate = new Date(item.day)
      if date > itemDate
        id = Number(item.id)
        storage.unregistParty(robot, id)
