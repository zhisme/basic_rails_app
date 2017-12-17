/*
 * decaffeinate suggestions:
 * DS101: Remove unnecessary use of Array.from
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// Make turbolinks work on error pages.
//
// https://github.com/turbolinks/turbolinks/issues/179

const success_codes = [403, 404];

Turbolinks.HttpRequest.prototype.requestLoaded = function() {
  return this.endRequest(() => {
    if ((200 <= this.xhr.status && this.xhr.status < 300) || Array.from(success_codes).includes(this.xhr.status)) {
      return this.delegate.requestCompletedWithResponse(this.xhr.responseText,
        this.xhr.getResponseHeader("Turbolinks-Location"));
    } else {
      this.failed = true;
      return this.delegate.requestFailedWithStatusCode(this.xhr.status, this.xhr.responseText);
    }
  });
};
