//= require ./config

if (!window.App) { window.App = {}; }

(function() {
  let $self;
  this.$self = ($self = $(this));

  this.on = function() { return $self.on(...arguments); };
  this.trigger = function() { return $self.triggerHandler(...arguments); };

  return this.log = function() { return window.DEBUG && console.log(...arguments); };
}).call(this.App);
