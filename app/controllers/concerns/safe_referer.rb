module SafeReferer
  class << self
    def url_matches?(url, regexp)
      if regexp.is_a?(String)
        url.starts_with?(regexp)
      else
        regexp =~ url
      end
    end

    def included(base)
      base.helper(self) if base.respond_to?(:helper)
    end
  end

  # Returns referer only if it is our.
  def safe_referer(path = false)
    unless defined?(@safe_referer)
      referer = request.referer
      root_url = self.root_url
      @safe_referer = referer&.starts_with?(root_url) ? referer : nil
      @safe_referer_path = @safe_referer && @safe_referer[(root_url.size - 1)..-1]
    end
    path ? @safe_referer_path : @safe_referer
  end

  # It returns `history.back()` to avoid extra page load if target location
  # equals referer. back_if option can be provided to use return js
  # in more cases, and back_unless to restrict:
  #
  #   # in order template:
  #   url_or_back orders_path, back_if: /^\/(products|shops)/
  def url_or_back(url, back_if: nil, back_unless: nil) # rubocop:disable CyclomaticComplexity
    case url
    when :back
      safe_referer ? 'javascript:history.back()' : redirect_fallback_path
    when String
      referer = safe_referer(true)
      if referer
        back = referer == url
        back ||= !SafeReferer.url_matches?(referer, back_unless) if back_unless
        back ||= SafeReferer.url_matches?(referer, back_if) if back_if
      end
      back ? 'javascript:history.back()' : url
    else url
    end
  end
end
