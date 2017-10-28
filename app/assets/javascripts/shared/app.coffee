#= require ./config

window.App ||= {}

(->
  @$self = $self = $(@)

  @on = -> $self.on arguments...
  @trigger = -> $self.triggerHandler arguments...

  @log = -> window.DEBUG && console.log(arguments...)
).call @App
