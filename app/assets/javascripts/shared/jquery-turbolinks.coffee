# https://github.com/kossnocorp/jquery.turbolinks/pull/58/files
# with some editions.

$document = $(document)

$.turbo =
  version: '3.0.0'

  isReady: false

  # Hook onto the events that Turbolinks triggers.
  use: (load, fetch) ->
    $document
      .off('.turbo')
      .on("#{load}.turbo", @onLoad)
      .on("#{fetch}.turbo", @onFetch)

  addCallback: (callback) ->
    callback($) if $.turbo.isReady
    $document.on 'turbo:ready', -> callback($)

  onLoad: ->
    $.turbo.isReady = true
    $document.trigger('turbo:ready')

  onFetch: ->
    $.turbo.isReady = false

  one: ->
    $(document).one('turbo:ready', arguments...)

  # Registers jQuery.Turbolinks by monkey-patching jQuery's
  # `ready` handler.
  # Override `$(function)` and `$(document).ready(function)` by
  # registering callbacks under a new event called `turbo:ready`.
  #
  register: ->
    $.fn.ready = @addCallback

# Use with Turbolinks.
$.turbo.register()
$.turbo.use('turbolinks:load', 'turbolinks:request-start')
