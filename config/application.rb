# frozen_string_literal: true

require_relative 'boot'

require 'rails'

## [DN] Pick the gems from rails that you want to use and disable the rest
## since we do not need them for this project. If you enable additional ones,
## you may need to enable some configuration that was intentionally disabled.
## E.g. ActiveStorage utilizes `config.active_storage` options.
## WARNING: This list changes with each rails upgrade so be sure to obtain the
## latest list each time. Run the following command to help with that:
## `cat $(bundle info --path railties)/lib/rails/all.rb`
require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
require 'active_job/railtie'
# require 'action_cable/engine'
# require 'action_mailbox/engine'
# require 'action_text/engine'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RorTemplate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    ## [DN] Make AJ use Sidekiq
    config.active_job.queue_adapter = :sidekiq

    config.middleware.insert_before 0,
                                    Rack::Cors,
                                    debug: ENV['RACK_CORS_DEBUG'] == 'enabled',
                                    logger: (-> { Rails.logger }) do
      allow do
        origins(*ENV.fetch('CORS_ORIGINS').split(','))
        resource '*', headers: :any, methods: :any, credentials: true
      end
    end
  end
end
