require 'sidekiq'
require 'sidekiq-status'

  Sidekiq.configure_client do |config|
   # accepts :expiration (optional)
   Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
  end

  Sidekiq.configure_server do |config|
   # accepts :expiration (optional)
   Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes

   # accepts :expiration (optional)
   Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
  end


redis_url = ENV['REDIS_URL']

  Sidekiq.configure_server do |config|
    config.redis = { password: ENV["REDIS_PASSWORD"], url: redis_url }
  end
  Sidekiq.configure_client do |config|
    config.redis = { password: ENV["REDIS_PASSWORD"], url: redis_url }
  end
