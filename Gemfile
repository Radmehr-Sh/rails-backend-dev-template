# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby ENV.fetch('RBENV_VERSION')

gem 'pgcrypto'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.4'
gem 'will_paginate', '~> 3.1.0'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'encrypted'
gem 'graphql', '~> 2.0', '>= 2.0.14'
gem 'jbuilder', '~> 2.7'
gem 'mimemagic', '~> 0.4.0'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1.1'
gem 'rubocop', '~> 1.15', require: false
gem 'sidekiq', '~> 6.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'json_matchers'
  gem 'rspec-rails', '~> 4.1.0'
  gem 'rubocop-rspec'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock', require: 'webmock/rspec'
end

group :development do
  gem 'graphiql-rails', git: 'https://github.com/rmosolgo/graphiql-rails.git', branch: 'master'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'dotenv-rails', groups: %i[development test]
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'rswag'


