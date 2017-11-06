module RunLater
  PREFIX = 'RunLater:Module:'.freeze

  class << self
    def dump(value)
      value.is_a?(Module) && value.name ? "#{PREFIX}#{value.name}" : value
    end

    def load(str)
      str.is_a?(String) && str.start_with?(PREFIX) ? str.sub(PREFIX, '').constantize : str
    end

    def run(object, method, *args)
      Job.perform_later(dump(object), method, *args)
    end

    def run_now(object, method, *args)
      load(object).public_send(method, *args)
    end
  end

  def run_later(*methods)
    generated_run_later_methods.class_eval do
      methods.each do |method|
        method = method.to_s
        stripped_method = method.sub(/([?!=])$/, '')
        suffix = Regexp.last_match(1)
        define_method "#{stripped_method}_later#{suffix}" do |*args|
          RunLater.run(self, method, *args)
        end
      end
    end
  end

  def generated_run_later_methods
    @generated_run_later_methods ||= Module.new.tap { |x| include x }
  end

  class Job < ApplicationJob
    def perform(object, method, *args)
      RunLater.run_now(object, method, *args)
    end
  end
end
