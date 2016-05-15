ready = ->
  $messages = $('#messages_container')
  height = $messages.height()
  speed = height / 1.5
  $('div').animate({ scrollTop: height, speed })

$(document).on('turbolinks:load', ready)
