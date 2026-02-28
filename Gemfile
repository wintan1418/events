source "https://rubygems.org"

gem "rails", "~> 8.1.2"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"

# Authentication & Authorization
gem "devise", "~> 4.9"
gem "pundit", "~> 2.4"

# Multi-tenancy
gem "acts_as_tenant", "~> 1.0"

# Background Jobs & Redis
gem "sidekiq", "~> 7.3"
gem "redis", "~> 5.3"

# Utilities
gem "friendly_id", "~> 5.5"
gem "image_processing", "~> 1.2"
gem "pagy", "~> 9.3"
gem "phonelib", "~> 0.9"
gem "inline_svg", "~> 1.10"
gem "caxlsx", "~> 4.1"

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.5"
  gem "letter_opener", "~> 1.10"
end

group :development do
  gem "web-console"
  gem "bullet", "~> 8.0"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 6.4"
  gem "simplecov", "~> 0.22", require: false
end
