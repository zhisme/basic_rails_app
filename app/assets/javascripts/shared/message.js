/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
//= require ./jquery-helpers

$.message = function(params) {
  if ($.isArray(params)) {
    return $.each(params, function() { return $.message(this); });
  }
  if ('string' === typeof params) { params = {content: params}; }
  params = $.extend({}, $.message.defaults, params);
  const message = $.message.build(params);
  const target = params.target != null ? params.target : $('#runtime-messages');
  target.append(message);
  if (params.closable) { message.closable(); }
  message.slideDown('slow');
  const delay = params.delay || (params.autohide && $.message.autohideDelay);
  if (delay) { return setTimeout((() => message.hidenremove('slow')), delay); }
};

$.message.build = params =>
  $('<div />').text(params.content).addClass(`alert ${params.style}`).hide()
    .append($('<button class="close" data-dismiss="alert">&times;</button>'))
;

$.message.autohideDelay = 5000;
$.message.defaults = {
  style:    'alert-info',
  autohide: true
};
  // closable: true

// $ -> $('.alert:not([data-closable=false])').closable()
