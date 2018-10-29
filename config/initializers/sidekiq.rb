require 'sidekiq/web'
require 'sidekiq-scheduler/web'

#Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
#Sidekiq::Web.set :sessions, Rails.application.config.session_options

Sidekiq.configure_server do |config|
  config.redis = {url: "redis://localhost:6379"}
end

Sidekiq.configure_client do |config|
  config.redis = {url: "redis://localhost:6379"}
end
