# frozen_string_literal: true

# Libraries
require 'active_support/all'
require 'churn_zero/version'
require 'faraday'
require File.expand_path('../churn_zero/configuration', __FILE__)
require File.expand_path('../churn_zero/api', __FILE__)
require File.expand_path('../churn_zero/client', __FILE__)

module ChurnZero
  extend Configuration

  # Alias for ChurnZero::Client.new
  # @return [ChurnZero::Client]
  def self.client(options = {})
    ChurnZero::Client.new(options)
  end

  # Delegate to ChurnZero::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)

    client.send(method, *args, &block)
  end
end
