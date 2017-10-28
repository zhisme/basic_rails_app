$document = $ document

# Live listener can not prevent remote-form listeners, so we add direct listener
# to form. Plugin prevents from attaching multiple direct listeners.
PluginManager.add 'preventableForm', class
  @RESUBMIT_TIMEOUT = 3000

  constructor: (@form) ->
    @onsubmit()
    @form.on 'submit', (e) => @onsubmit(e)

  onsubmit: (e) ->
    now = + new Date
    if @submittedAt && now - @submittedAt < @constructor.RESUBMIT_TIMEOUT
      console.log 'Re-Submit prevented'
      e.stopPropagation()
      e.stopImmediatePropagation()
      e.preventDefault()
      false
    else
      @submittedAt = now

$document.on 'submit', 'form', (e) -> $(@).preventableForm()

# Forwards click event. Useful to create custom file inputs and similar.
$document.on 'click', '[data-forward="click"]', (e) ->
  e.preventDefault()
  $event_target = $(@)
  selector = $event_target.attr('href') || $event_target.data('target')
  parent_selector = $event_target.data('parent')
  target =
    if parent_selector
      $event_target.closest(parent_selector).find(selector)
    else
      $(selector)
  target.click()

# Define callback to run to init interface.
# It usually runs on page load, but may run also when new elements added to page.
#
# Use it without arguments to run defuned callbacks.
$.initInterface = (fn) ->
  if fn
    $document.on('init-inputs', fn)
  else
    $document.triggerHandler('init-inputs')

$ -> $.initInterface()
