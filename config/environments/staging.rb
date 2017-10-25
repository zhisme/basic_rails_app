SYSLOG_TAG = 'basic_rails_app-staging'.freeze

require_relative './production'

Rails.application.configure do
  # Override production config here.
end
