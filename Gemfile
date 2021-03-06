source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

gem 'annotate', '~> 2.6.5'
gem 'slim-rails'

gem "twitter-bootstrap-rails"
gem 'simple_form'

# icons
gem "font-awesome-rails"

# for js templates
gem 'ejs'

#authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'

#autorisation
gem 'pundit'

#responders
gem 'responders', '~> 2.0'

#pub/sub
gem 'private_pub'
gem 'thin'

# api
gem 'doorkeeper'
gem 'active_model_serializers'
gem 'oj'
gem 'oj_mimic_json'

gem 'carrierwave'
gem 'remotipart'
gem 'nested_form', git: 'git://github.com/ryanb/nested_form.git'

# delayed jobs
gem 'whenever'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'sidetiq'

# search
gem 'mysql2'
gem 'thinking-sphinx'

# env config
gem 'dotenv'
gem 'dotenv-deployment', require: 'dotenv/deployment'

# assets precompile
gem 'therubyracer'

gem 'unicorn'

#cache
gem 'redis-rails'

# observers
gem 'rails-observers'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-unicorn', require: false
  #gem 'capistrano-rails-console', require: false
  #gem 'capistrano-thin', require: false
  #gem 'capistrano-sphinx', require: false
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara-webkit'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'json_spec'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
