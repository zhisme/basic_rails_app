Rails.application.config.after_initialize do
  next unless defined?(Bullet)

  Bullet.tap do |config|
    case Rails.env
    when 'development'
      config.enable         = true
      config.alert          = false
      config.console        = true
      config.add_footer     = true
      config.bullet_logger  = false
      config.rails_logger   = true
      # config.raise          = true
    when 'test'
      config.enable = true
      config.raise = true
    end

    if config.enable?
      # add whitelist rules here
    end
  end
end
