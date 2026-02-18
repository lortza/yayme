# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").strip
gem "rails", "~> 7.2.3"       # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem "activestorage-dropbox", "~> 2.0" # connects activestorage and dropbox
gem "dropbox_api"               # dependency for the activestorage-dropbox gem
gem "bootsnap", ">= 1.1.0", require: false # Reduces boot times through caching; required in config/boot.rb
gem "coderay"                   # syntax highlighting: http://coderay.rubychan.de/
gem "devise"                    # User authentication
gem "image_processing", "~> 1.2" # Creates various sizes for ActiveStorage image files
gem "jbuilder"                   # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "loofah"                    # HTML sanitizer
gem "nokogiri"                  # HTML, XML, SAX, and Reader parsers with XPath and CSS selector support
gem "pg"                        # Use PostgreSQL as the database
gem "puma"                      # Use Puma as the app server
gem "rack"                      # modular Ruby webserver interface. Required for Action Cable and other middleware.
gem "redcarpet", github: "vmg/redcarpet" # markdown
gem "will_paginate", "~> 3.3"   # Pagination. Styles: http://mislav.github.io/will_paginate/

# gem "net-imap", require: false  # IMAP client library for Ruby
# gem "net-pop", require: false   # POP3 client library for Ruby
# gem "net-smtp", require: false  # Send internet mail via SMTP protocol

gem "sentry-rails"              # Rails support for Sentry
gem "sentry-ruby"               # Error reporting to Sentry.io
gem "sprockets-rails"           # The original asset pipeline for Rails 
gem 'pundit'                    # Authorization library
gem "oauth2", "~> 1.4"

group :development, :test do
  gem "rspec-rails"
  gem "better_errors"           # creates console in browser for errors
  gem "binding_of_caller"       # goes with better_errors
  gem "bullet"                  # detects n+1 queries
  gem "byebug", platforms: %i[mri windows] # Call 'byebug' anywhere in the code to get a debugger console
  gem "faker"                   # creates seed data for specs
  gem "pry-rails"
  gem "reek" # https://github.com/troessner/reek/blob/master/docs/Code-Smells.md
end

group :development do
  gem "annotate" # lists db table details as comments in models, etc
  gem "awesome_print"
  gem "listen", ">= 3.0.5", "< 3.3"
  gem "magic_frozen_string_literal"
  gem "rails-erd" # , require: false   # generates table diagram run `bundle exec erd`
  gem "rubycritic", require: false     # provides stats on code build
  gem "standard", ">= 1.35.1"          # Linter for ruby files
  # gem "rubocop", require: false
  # gem 'rubocop-performance'
  # gem 'rubocop-rails'
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"        # Access an IRB console by using <%= console %> anywhere in the code.
end

group :test do
  gem "factory_bot_rails"       # factory support for rspec
  gem "launchy"                 # open browser with save_and_open_page
  gem "shoulda-matchers"        # library for easier testing syntax
  gem "selenium-webdriver"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

