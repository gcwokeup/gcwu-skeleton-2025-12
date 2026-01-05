source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.6"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Dart Sass for stylesheet compilation (no Node.js required)
gem "dartsass-rails"
# Bootstrap 5 for Rails
gem "bootstrap", "~> 5.3"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Authentication and Authorization
gem "devise", "~> 4.9"
gem "omniauth-google-oauth2", "~> 1.1"
gem "omniauth-rails_csrf_protection", "~> 1.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Redis for caching, ActionCable, and background jobs
gem "redis", "~> 5.0"
gem "hiredis-client" # C-based Redis client for better performance

# Background job processing
gem "sidekiq", "~> 7.0"

# Optional but recommended: Better Redis connection pooling
gem "connection_pool"

# AWS S3 for Active Storage
gem "aws-sdk-s3", require: false

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", require: false

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Generate fake data for seeds/tests
  gem "faker"

  # Test data factories
  gem "factory_bot_rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Process manager for running multiple services
  gem "foreman"

  # Autoload dotenv in Rails
  gem "dotenv-rails", "~> 2.1", ">= 2.1.1"

  # Auto-generate schema documentation in models
  gem "annotate"

  # Better error pages with REPL
  gem "better_errors"
  gem "binding_of_caller" # Required for better_errors advanced features

  # N+1 query detection
  gem "bullet"

  # Preview emails in browser instead of sending
  gem "letter_opener"

  # Better console than IRB
  gem "pry-rails"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"

  # One-liner testing matchers
  gem "shoulda-matchers"

  # Code coverage
  gem "simplecov", require: false
end

# Additional production gems
gem "pagy" # Fast, lightweight pagination
