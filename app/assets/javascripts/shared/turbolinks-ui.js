/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// Remove still animating alerts.
$(document).on('turbolinks:before-cache', function() {
  $('.alert').remove();

  if ($.fn.modal) {
    return $.withoutBsTransitions(() => $('.modal').modal('hide'));
  }
});
