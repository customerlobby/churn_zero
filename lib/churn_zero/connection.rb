# frozen_string_literal: true

require 'faraday_middleware'

module ChurnZero
  module Connection
    private

    def connection
      options = {
        url: "#{endpoint}/"
      }

      Faraday::Connection.new(options) do |connection|
        connection.adapter(adapter)
      end
    end
  end
end