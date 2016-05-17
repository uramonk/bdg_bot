_ = require 'lodash'

module.exports = (robot) ->
  robot.respond /.*/, (msg) ->
    unless _.contains [process.env.HUBOT_SLACK_CHANNEL, process.env.HUBOT_SLACK_CHANNEL_DEV], msg.envelope.room
      msg.finish()
      return

    if /bot/.test msg.envelope.user.name
      msg.finish()
      return

  robot.hear /.*/, (msg) ->
    unless _.contains [config.getSlackChannel()], msg.envelope.room
      msg.finish()
      return