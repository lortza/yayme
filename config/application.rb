require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yayme
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.

    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :local # Or :utc

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
