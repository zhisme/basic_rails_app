#= require ./jquery-helpers

$.message = (params) ->
  if $.isArray(params)
    return $.each params, -> $.message this
  params = {content: params} if 'string' is typeof params
  params = $.extend {}, $.message.defaults, params
  message = $.message.build(params)
  target = params.target ? $('#runtime-messages')
  target.append message
  message.closable() if params.closable
  message.slideDown 'slow'
  delay = params.delay || params.autohide && $.message.autohideDelay
  setTimeout (-> message.hidenremove 'slow'), delay if delay

$.message.build = (params) ->
  $('<div />').text(params.content).addClass("alert #{params.style}").hide()
    .append($('<button class="close" data-dismiss="alert">&times;</button>'))

$.message.autohideDelay = 5000
$.message.defaults =
  style:    'alert-info'
  autohide: true
  # closable: true

# $ -> $('.alert:not([data-closable=false])').closable()
