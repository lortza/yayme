# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").strip

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.0"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Use postgres as the database for Active Record
gem "pg"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

gem "csv"                      # CSV parsing and generation

gem "devise"                    # User authentication
gem 'pundit'                    # Authorization library

gem "activestorage-dropbox", "~> 2.0" # connects activestorage and dropbox
gem "dropbox_api"               # dependency for the activestorage-dropbox gem

gem "coderay"                   # syntax highlighting: http://coderay.rubychan.de/
gem "redcarpet", github: "vmg/redcarpet" # markdown
gem "pagy"                      # Pagination: https://github.com/ddnexus/pagy?tab=readme-ov-file. Styles: https://ddnexus.github.io/pagy/resources/stylesheets/

# gem "net-imap", require: false  # IMAP client library for Ruby
# gem "net-pop", require: false   # POP3 client library for Ruby
# gem "net-smtp", require: false  # Send internet mail via SMTP protocol

gem "sentry-rails"              # Rails support for Sentry
gem "sentry-ruby"               # Error reporting to Sentry.io

group :development, :test do
  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", require: false
  
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
  
  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  
  
  gem "rspec-rails"
  gem "better_errors"           # creates console in browser for errors
  gem "binding_of_caller"       # goes with better_errors
  gem "byebug", platforms: %i[mri windows] # Call 'byebug' anywhere in the code to get a debugger console
  gem "faker"                   # creates seed data for specs
  gem "pry-rails"
end

group :development do
  gem "annotate" # lists db table details as comments in models, etc
  gem "awesome_print"
  gem "magic_frozen_string_literal"
  
  gem "bullet"                  # detects n+1 queries
  gem "rails-erd" # , require: false   # generates table diagram run `bundle exec erd`
  gem "rubycritic", require: false     # provides stats on code build
  gem "standard", ">= 1.35.1"          # Linter for ruby files
  gem "web-console", ">= 3.3.0"        # Access an IRB console by using <%= console %> anywhere in the code.
end

group :test do
  gem "factory_bot_rails"       # factory support for rspec
  gem "launchy"                 # open browser with save_and_open_page
  gem "shoulda-matchers"        # library for easier testing syntax
  gem "capybara"
  gem "selenium-webdriver"
end
