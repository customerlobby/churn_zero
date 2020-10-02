# frozen_string_literal: true

require File.expand_path('../../churn_zero/errors/request_error', __dir__)

module ChurnZero
  class Client
    module Attribute

      def write(options = {})
        validate!(options)
        options.merge!(action: 'setAttribute')

        get(options)
      end

      def increment(options = {})
        validate!(options)
        options.merge!(action: 'incrementAttribute')

        get(options)
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
          contact_external_id
          entity
          name
          value
        ]
      end
    end
  end
end