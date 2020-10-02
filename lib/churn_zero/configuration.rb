# frozen_sring_literal: true

module ChurnZero
  module Configuration

    VALID_OPTIONS_KEYS = [
        :app_key,
        :adapter,
        :endpoint
    ].freeze

    # By default don't set the app key.
    DEFAULT_APP_KEY = nil

    # Use the default Faraday adapter.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default use the main ChurnZero api URL.
    DEFAULT_ENDPOINT = 'https://analytics.churnzero.net/i'.freeze

    # By default request JSON data to be returned from the API.
    DEFAULT_FORMAT = :json

    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # When this module is extended, reset all settings.
    def self.extended(base)
      base.reset
    end

    # Reset all configuration settings to default values.
    def reset
      self.app_key     = DEFAULT_APP_KEY
      self.endpoint    = DEFAULT_ENDPOINT
      self.adapter     = DEFAULT_ADAPTER
    end
  end
end