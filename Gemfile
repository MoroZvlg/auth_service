# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'puma'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib'


gem 'sequel'
gem 'sequel-seed'
gem 'bcrypt', require: false
gem 'jwt'
gem 'pg'

gem 'i18n'
gem 'config'

gem 'fast_jsonapi'
gem 'activesupport', require: false

gem 'prometheus-client'

gem 'rack-ougai'
gem 'amazing_print' # нужен для ouagi!

gem 'dry-initializer'
gem 'dry-validation'

group :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'rack-test'
  gem 'database_cleaner-sequel'
end
