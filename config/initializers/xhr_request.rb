# Remove html fallback for js requests.

module ActionView
  LookupContext.class_eval do
    # Don't add html format for js requests, to not render html templates.
    # `render` will raise MissingTemplate and responder catches it to render
    # default js action.
    def formats=(values)
      values.concat(default_formats) if values&.delete('*/*'.freeze)
      super(values)
    end
  end

  AbstractRenderer.class_eval do
    # Change it to 'append', so it doesn't override explicit format.
    # It uses only first one from `#formats` to detect layout,
    # and js layout won't be found if html partial or template was rendered.
    def prepend_formats(formats)
      formats = Array(formats)
      return if formats.empty?
      @lookup_context.formats = @lookup_context.formats | formats
    end
  end
end

# Disable Accept header till, rails-ujs adds `*/*`,
# so app renders html templates.
# Rails.application.config.action_dispatch.ignore_accept_header = true
# ActionDispatch::Request.ignore_accept_header = true
