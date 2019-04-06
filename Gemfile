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
gem 'will_paginate'
gem 'bootstrap-will_paginate'
#gem 'carrierwave'
gem 'mini_magick'
#gem 'fog', '1.40.0'
gem 'shrine', '~> 2.11'
gem 'shrine-memory'
gem 'image_processing', '~>1.0'
gem "aws-sdk-s3", "~> 1.2"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'hirb'
  gem 'hirb-unicode', '0.0.5'
  gem 'rubocop', require: false
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.3.6'
  gem 'rails-controller-testing'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'dotenv-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
end

group :production do
  gem 'pg'
end

