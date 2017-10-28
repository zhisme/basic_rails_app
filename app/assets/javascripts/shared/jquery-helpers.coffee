# Collection of jq utils.

# Animate remove.
$.fn.hidenremove = (speed = 'slow', animation = 'slideUp') ->
  @[animation] speed, -> $(@).remove()

# Make element closable with click.
$.fn.closable = (speed, animation) ->
  @click -> $(@).hidenremove(speed, animation)

# Remove and attach handler to make sure it attached only once.
$.fn.offOn = (name, handler) -> @off(name, handler).on(name, handler)

# Disable bootstrap collapse transitions for given block.
$.withoutBsTransitions = (fn) ->
  old = $.support.transition
  $.support.transition = false
  result = fn()
  $.support.transition = old
  result

# Makes all $() calls without explicit context use passed context.
# Useful when working with page snapshots, or before turbolinks inserts content.
$.within = (context, fn) ->
  old = $.defaultContext
  $.defaultContext = context
  result = fn()
  $.defaultContext = old
  result

$.fn.originalInit = $.fn.init
$.fn.init = (selector, context = $.defaultContext, root) ->
  new $.fn.originalInit(selector, context, root)

# Performs animated scroll to the first input with error and focuses on it.
$.fn.scrollToError = ->
  has_error = @find('.has-error:visible:first')
  $('body').animate
    scrollTop: if has_error.length
        has_error.offset().top - 120
      else
        @offset().top - 120
    -> has_error.find(':input:visible:first').focus()

# Replaces element on the page by id.
$.findAndReplace = (str) ->
  el = $(str)
  return unless id = el.attr 'id'
  $("##{id}").replaceWith(el)
  el
