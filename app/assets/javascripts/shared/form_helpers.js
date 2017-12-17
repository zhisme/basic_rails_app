/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS206: Consider reworking classes to avoid initClass
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const $document = $(document);

// Live listener can not prevent remote-form listeners, so we add direct listener
// to form. Plugin prevents from attaching multiple direct listeners.
PluginManager.add('preventableForm', (function() {
  const Cls = class {
    static initClass() {
      this.RESUBMIT_TIMEOUT = 3000;
    }

    constructor(form) {
      this.form = form;
      this.onsubmit();
      this.form.on('submit', e => this.onsubmit(e));
    }

    onsubmit(e) {
      const now = + new Date;
      if (this.submittedAt && ((now - this.submittedAt) < this.constructor.RESUBMIT_TIMEOUT)) {
        console.log('Re-Submit prevented');
        e.stopPropagation();
        e.stopImmediatePropagation();
        e.preventDefault();
        return false;
      } else {
        return this.submittedAt = now;
      }
    }
  };
  Cls.initClass();
  return Cls;
})()
);

$document.on('submit', 'form', function(e) { return $(this).preventableForm(); });

// Forwards click event. Useful to create custom file inputs and similar.
$document.on('click', '[data-forward="click"]', function(e) {
  e.preventDefault();
  const $event_target = $(this);
  const selector = $event_target.attr('href') || $event_target.data('target');
  const parent_selector = $event_target.data('parent');
  const target =
    parent_selector ?
      $event_target.closest(parent_selector).find(selector)
    :
      $(selector);
  return target.click();
});

// Define callback to run to init interface.
// It usually runs on page load, but may run also when new elements added to page.
//
// Use it without arguments to run defuned callbacks.
$.initInterface = function(fn) {
  if (fn) {
    return $document.on('init-inputs', fn);
  } else {
    return $document.triggerHandler('init-inputs');
  }
};

$(() => $.initInterface());
