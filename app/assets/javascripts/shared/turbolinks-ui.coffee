# Remove still animating alerts.
$(document).on 'turbolinks:before-cache', ->
  $('.alert').remove()

  if $.fn.modal
    $.withoutBsTransitions -> $('.modal').modal('hide')
