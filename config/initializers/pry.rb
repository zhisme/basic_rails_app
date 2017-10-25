if defined?(Pry)
  Pry.config.print = proc do |_output, value|
    ap = AwesomePrint::Inspector.new(indent: 2, ruby19_syntax: true)
    pager = Pry.new.pager
    pretty = ap.awesome(value)
    pager.page "=> #{pretty}"
  end
end
