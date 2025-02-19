# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'
gem 'rails', '~> 7.2.2.1'       # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem 'activestorage-dropbox', '~> 2.0' # connects activestorage and dropbox
gem 'dropbox_api'               # dependency for the activestorage-dropbox gem
gem 'bootsnap', '>= 1.1.0', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'coderay'                   # syntax highlighting: http://coderay.rubychan.de/
gem 'coffee-rails'              # Use CoffeeScripgt for .coffee assets and views
gem 'devise'                    # User authentication
gem 'image_processing', '~> 1.2'# Creates various sizes for ActiveStorage image files
gem 'jbuilder', '~> 2.5'        # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'loofah', '>= 2.2.3'        # Upgrade for security update
gem 'nokogiri', '>= 1.8.5'      # Upgrade for security update
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'                      # Use Puma as the app server
gem 'rack', '>= 2.0.6'          # Upgrade for security update
gem 'redcarpet', github: 'vmg/redcarpet' # markdown
gem 'sass-rails', '~> 6.0'      # Use SCSS for stylesheets
gem 'will_paginate', '~> 3.3'   # Pagination. Styles: http://mislav.github.io/will_paginate/
# gem 'redis', '~> 4.0'           # Use Redis adapter to run Action Cable in production
# gem 'capistrano-rails', group: :development # Use Capistrano for deployment
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false # Send internet mail via SMTP
gem 'sentry-rails'              # Rails support for Sentry
gem 'sentry-ruby'               # Error reporting to Sentry.io

group :development, :test do
  gem 'rspec-rails'
  gem 'better_errors'           # creates console in browser for errors
  gem 'binding_of_caller'       # goes with better_errors
  gem 'bullet'                  # detects n+1 queries
  gem 'byebug', platforms: %i[mri mingw x64_mingw] # Call 'byebug' anywhere in the code to get a debugger console
  gem 'faker'                   # creates seed data for specs
  gem 'pry-rails'
  gem 'reek' # https://github.com/troessner/reek/blob/master/docs/Code-Smells.md
end

group :development do
  gem 'annotate' # lists db table details as comments in models, etc
  gem 'awesome_print'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'magic_frozen_string_literal'
  gem 'rails-erd' # , require: false   # generates table diagram run `bundle exec erd`
  gem 'rubycritic', require: false # provides stats on code build
  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'scss_lint', require: false # css linter
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # Access an IRB console by using <%= console %> anywhere in the code.
end

group :test do
  gem 'factory_bot_rails'       # factory support for rspec
  gem 'launchy'                 # open browser with save_and_open_page
  gem 'shoulda-matchers'        # library for easier testing syntax
  gem "selenium-webdriver"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
