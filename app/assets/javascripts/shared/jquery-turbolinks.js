/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// https://github.com/kossnocorp/jquery.turbolinks/pull/58/files
// with some editions.

const $document = $(document);

$.turbo = {
  version: '3.0.0',

  isReady: false,

  // Hook onto the events that Turbolinks triggers.
  use(load, fetch) {
    return $document
      .off('.turbo')
      .on(`${load}.turbo`, this.onLoad)
      .on(`${fetch}.turbo`, this.onFetch);
  },

  addCallback(callback) {
    if ($.turbo.isReady) { callback($); }
    return $document.on('turbo:ready', () => callback($));
  },

  onLoad() {
    $.turbo.isReady = true;
    return $document.trigger('turbo:ready');
  },

  onFetch() {
    return $.turbo.isReady = false;
  },

  one() {
    return $(document).one('turbo:ready', ...arguments);
  },

  // Registers jQuery.Turbolinks by monkey-patching jQuery's
  // `ready` handler.
  // Override `$(function)` and `$(document).ready(function)` by
  // registering callbacks under a new event called `turbo:ready`.
  //
  register() {
    return $.fn.ready = this.addCallback;
  }
};

// Use with Turbolinks.
$.turbo.register();
$.turbo.use('turbolinks:load', 'turbolinks:request-start');
