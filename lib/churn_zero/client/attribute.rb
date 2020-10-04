# frozen_string_literal: true

require File.expand_path('../../churn_zero/errors/request_error', __dir__)

module ChurnZero
  class Client
    module Attribute
      # used to set attributes
      def write(options)
        return write_all(options) if options.is_a? Array

        options.merge!(action: 'setAttribute')
        validate!(options)
        get(options)
      end

      def increment(options = {})
        validate!(options)
        options.merge!(action: 'incrementAttribute')

        get(options)
      end

      def write_all(options)
        options.each do |element|
          element[:action] = 'setAttribute'
          validate!(element)
        end

        post(options)
      end

      def validate!(options)
        errors = []
        required_attributes.each do |attr|
          errors << attr unless options[attr].present?
        end
        return if errors.blank?

        raise ChurnZero::Error::RequestError, "Parameters Missing - #{errors.join(', ')}"
      end

      def required_attributes
        %i[
          account_external_id
          action
          entity
          name
        ]
      end
    end
  end
end