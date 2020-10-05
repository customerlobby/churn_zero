# frozen_string_literal: true

require File.expand_path('request', __dir__)
require File.expand_path('response', __dir__)
require File.expand_path('connection', __dir__)

module ChurnZero
  class API
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    include Request
    include Response
    include Connection
    def initialize(options = {})
      options = ChurnZero.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end
  end
end
