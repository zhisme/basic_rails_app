# Make turbolinks work on error pages.
#
# https://github.com/turbolinks/turbolinks/issues/179

success_codes = [403, 404]

Turbolinks.HttpRequest::requestLoaded = ->
  @endRequest =>
    if 200 <= @xhr.status < 300 or @xhr.status in success_codes
      @delegate.requestCompletedWithResponse(@xhr.responseText,
        @xhr.getResponseHeader("Turbolinks-Location"))
    else
      @failed = true
      @delegate.requestFailedWithStatusCode(@xhr.status, @xhr.responseText)
