# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'coffee-rails'
gem 'font-awesome-rails'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
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
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
end

group :production do
  gem 'pg'
end

