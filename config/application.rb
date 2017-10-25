require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
# require "action_cable/engine"
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Bundler.require(:assets) if Rails.env.in?(%w[development test])
# load pry for dev, test & production console
Bundler.require(:pry) if !Rails.env.production? || defined?(Rails::Console)

module BasicRailsApp
  HTTP_PROTOCOL = Rails.env.in?(%w[staging production]) ? :https : :http
  DOMAIN = (Rails.env.staging? ? 'staging.example.com' : 'example.com').freeze
  ENV_DOMAIN = Rails.env.development? ? 'localhost:3000'.freeze : DOMAIN
  ENV_HOST = "#{HTTP_PROTOCOL}://#{ENV_DOMAIN}".freeze

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.app_name = Module.nesting.last.name.downcase

    # config.time_zone = 'UTC'

    config.i18n.default_locale = :en
    config.i18n.available_locales = %i[en]

    # Don't include all helpers to avoid collisions.
    config.action_controller.include_all_helpers = false

    routes.default_url_options[:host] = ENV_DOMAIN
    config.action_mailer.asset_host = ENV_HOST

    config.action_mailer.default_options = {
      from: "BasicRailsApp Robot<noreply@#{DOMAIN}>",
      'Message-ID' => ->(*) { "<#{SecureRandom.uuid}@#{DOMAIN}>" },
    }

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
