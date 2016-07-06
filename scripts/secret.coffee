module.exports = (robot) ->
  robot.hear /遅刻します|ちこくします|遅刻しそう|ちこくしそう|遅れます|おくれます|おくれそう|遅れそう|まにあわな|間に合わな|間にあわな/, (msg) ->
    msg.send "@#{msg.envelope.user.name} は？"
