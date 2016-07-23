module.exports = (robot) ->
  robot.hear /遅刻します|ちこくします|遅刻しそう|ちこくしそう|遅れます|おくれます|おくれそう|遅れそう|まにあわな|間に合わな|間にあわな/, (msg) ->
    messages = ["は？", "え？", "本気で言ってんの？", "3分間待ってやる"]
    index = Math.floor(Math.random() * messages.length)
    message = messages[index]
    msg.send "@#{msg.envelope.user.name} #{message}"
