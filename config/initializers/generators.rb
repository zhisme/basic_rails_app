Rails.application.configure do
  # Generate request spec insted of controller for `rails g controller`.
  def self.load_generators(*)
    super
    require 'rails/generators/rails/controller/controller_generator'
    Rails::Generators::ControllerGenerator.class_eval do
      remove_hook_for :test_framework
      hook_for :test_framework, as: :request
    end
  end

  # This generators are rarely used.
  config.generators do |g|
    g.stylesheets = false
    g.javascripts = false
    g.helper      = false
  end
end
