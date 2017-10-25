# Force httponly cookies with Same-Site option.
Rails.application.config.session_store :cookie_store,
  key: '_basic_rails_app_session',
  httponly: true,
  secure: Rails.env.production?,
  same_site: :Lax
