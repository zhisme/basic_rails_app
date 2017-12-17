module Support
  # Override process methods, so we can use rails5 specs within rails4.
  module ControllerBackport
    %w[get post put patch delete].each do |method|
      define_method(method) do |path, **options|
        params = options[:params] || {}
        super(path, params)
      end
    end
  end
end

RSpec.configure do |config|
  if Rails::VERSION::MAJOR >= 5
    require 'rails-controller-testing'
    %i[controller view request].each do |type|
      config.include ::Rails::Controller::Testing::TestProcess, type: type
      config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
      config.include ::Rails::Controller::Testing::Integration, type: type
    end
  else
    %i[controller request].each do |type|
      config.include Support::ControllerBackport, type: type
    end
  end
end
