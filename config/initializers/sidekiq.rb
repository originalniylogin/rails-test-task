Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: "app3_sidekiq_#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: "app3_sidekiq_#{Rails.env}" }
end

Sidekiq::Extensions.enable_delay!