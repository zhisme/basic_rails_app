module ApplicationHelper
  include BootstrapHelper
  # Adds pagination before and after output of block.
  def paginate(target = collection, *args, &block)
    pagination = super
    return pagination unless block_given?
    pagination + capture(&block) + pagination
  end

  # Represent any object as html-safe json.
  def safe_json(val)
    val.to_json.html_safe # rubocop:disable OutputSafety
  end
end
