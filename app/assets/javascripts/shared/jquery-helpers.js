/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// Collection of jq utils.

// Animate remove.
$.fn.hidenremove = function(speed, animation) {
  if (speed == null) { speed = 'slow'; }
  if (animation == null) { animation = 'slideUp'; }
  return this[animation](speed, function() { return $(this).remove(); });
};

// Make element closable with click.
$.fn.closable = function(speed, animation) {
  return this.click(function() { return $(this).hidenremove(speed, animation); });
};

// Remove and attach handler to make sure it attached only once.
$.fn.offOn = function(name, handler) { return this.off(name, handler).on(name, handler); };

// Disable bootstrap collapse transitions for given block.
$.withoutBsTransitions = function(fn) {
  const old = $.support.transition;
  $.support.transition = false;
  const result = fn();
  $.support.transition = old;
  return result;
};

// Makes all $() calls without explicit context use passed context.
// Useful when working with page snapshots, or before turbolinks inserts content.
$.within = function(context, fn) {
  const old = $.defaultContext;
  $.defaultContext = context;
  const result = fn();
  $.defaultContext = old;
  return result;
};

$.fn.originalInit = $.fn.init;
$.fn.init = function(selector, context, root) {
  if (context == null) { context = $.defaultContext; }
  return new $.fn.originalInit(selector, context, root);
};

// Performs animated scroll to the first input with error and focuses on it.
$.fn.scrollToError = function() {
  const has_error = this.find('.has-error:visible:first');
  return $('body').animate({
    scrollTop: has_error.length ?
        has_error.offset().top - 120
      :
        this.offset().top - 120
  },
    () => has_error.find(':input:visible:first').focus());
};

// Replaces element on the page by id.
$.findAndReplace = function(str) {
  let id;
  const el = $(str);
  if (!(id = el.attr('id'))) { return; }
  $(`#${id}`).replaceWith(el);
  return el;
};
