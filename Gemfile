ruby '2.4.1'
source 'https://rubygems.org'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

# Base
gem 'rails', '5.1.4'

# Infrastructure
gem 'pg', '0.21.0'
gem 'puma', '3.10.0'

# Models
gem 'kaminari', '1.1.1'

# Controllers
gem 'has_scope', '0.7.1'
gem 'responders', '2.4.0'
gem 'simple_form', '3.5.0'

# Views
gem 'slim-rails', '3.1.2'
gem 'turbolinks', '5.0.1'

# Instrumentation
gem 'rollbar', '2.15.4'

# Separate group for assets, so we don't load this gems when not using them in production.
group :assets do
  # Tools
  gem 'autoprefixer-rails', '7.1.6'
  gem 'coffee-rails', '~> 4.2'
  gem 'sass-rails', '5.0.6'

  # Libs
  gem 'bootstrap', '4.0.0.beta2.1'
  gem 'jquery-rails', '4.3.1'
  gem 'uglifier', '3.2.0'
end

group :pry do
  gem 'awesome_print', '1.8.0'
  gem 'byebug', '9.1.0'
  gem 'pry', '0.11.2'
  gem 'pry-byebug', '3.5.0'
  gem 'pry-doc', '0.11.1'
  gem 'pry-rails', '0.3.6'
end

group :development do
  # Spring
  gem 'listen', '3.1.5'
  gem 'spring', '2.0.2'
  gem 'spring-commands-rspec', '1.0.4'
  gem 'spring-watcher-listen', '2.0.1'

  # Linters
  gem 'brakeman', '4.0.1', require: false
  gem 'rubocop', '0.51.0', require: false
  gem 'scss_lint', '0.56.0', require: false
  gem 'slim_lint', '0.15.0', require: false

  # Dev tools
  gem 'web-console', '3.5.1'
end

group :development, :test do
  # RSpec
  gem 'rspec-rails', '3.7.1'

  # Spec utils, useful in dev
  gem 'factory_bot_rails', '4.8.2'
  gem 'timecop', '0.9.1'

  # QA
  gem 'bullet', '5.6.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'rspec-its', '1.2.0'
end
