Slim::Engine.set_options(
  js_wrapper: :cdata,
  pretty:     false,
)

class << Tilt::Template
  # Creates template from heredoc setting source info.
  def from_heredoc(str, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    file, line = args

    if options.fetch(:strip) { true }
      indent = str.scan(/^[ \t]*(?=\S)/)
      indent = indent&.min&.size || 0
      str = str.gsub(/^[ \t]{#{indent}}/, '')
    end

    unless file
      location = caller_locations(1, 1)[0]
      line = location.lineno + 1
      file = location.path
    end

    new(file, line) { str }
  end
end

Tilt::Template.prepend Module.new {
  # Slim escapes everything, but does not mark rendered templates are html safe.
  # We make it manually.
  def render(*)
    super.html_safe # rubocop:disable OutputSafety
  end
}
