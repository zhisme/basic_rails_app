# Seems to be the only way to set this option.
SassC::Engine.send(:define_method, :precision) { 8 } if defined?(SassC)
