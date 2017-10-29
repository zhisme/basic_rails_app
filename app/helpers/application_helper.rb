module ApplicationHelper
  include RailsStuff::Helpers::Bootstrap
  include RailsStuff::Helpers::Translation

  # Represent any object as html-safe json.
  def safe_json(val)
    val.to_json.html_safe # rubocop:disable OutputSafety
  end
end
