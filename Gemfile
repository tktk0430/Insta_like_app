# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'coffee-rails'
gem 'font-awesome-rails'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'email_validator', '~> 1.6'
gem 'rails-i18n', '~> 5.1'
gem 'solargraph'
gem 'therubyracer'
gem 'kaminari'
gem 'kaminari-i18n'
gem 'faker'
gem 'yoshida'
gem 'mini_magick'
gem 'shrine', '~> 2.11'
gem 'shrine-memory'
gem 'image_processing', '~>1.0'
gem "aws-sdk-s3", "~> 1.2"
gem "device"
gem "omniauth-facebook"


group :development, :test do
  gem 'hirb'
  gem 'hirb-unicode', '0.0.5'
  gem 'rubocop', require: false
  gem 'sqlite3', '~> 1.3.6'
  gem 'rails-controller-testing'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem "factory_bot_rails"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
end

