source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :staging, :test do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-remote'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'rubocop'
end

group :development do
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'binding_of_caller'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Misc
gem 'config'
gem 'dotenv-rails'
gem 'pry-rails'
gem 'faraday'

# Database
gem 'pg', '~> 0.18'
gem 'activerecord-postgis-adapter'

# Auth & permissions
gem 'bcrypt', '~> 3.1.7'

# Libs
gem 'rgeo'
gem 'rgeo-geojson'
gem 'will_paginate'
gem 'will_paginate-bootstrap4'

# Background/async processing
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sidekiq-limit_fetch'
gem 'sidekiq-scheduler'

# Tech
gem 'graphql'
gem 'graphql-errors'
gem 'graphql-pundit'
gem 'graphql-rails-resolver'

# Deployment
gem 'capistrano-rails', group: :development
gem 'capistrano-rvm'

# Frontend
#gem 'sass-rails'
gem 'slim'
gem 'slim-rails'
