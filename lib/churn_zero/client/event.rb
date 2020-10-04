# frozen_string_literal: true

module ChurnZero
  class Client
    module Event
      # used to track events
      def track(options)
        return track_all(options) if options.is_a? Array

        options[:action] = 'trackEvent'
        validate_track_attrs!(options)
        get(options)
      end

      def track_all(options)
        options.each do |element|
          element[:action] = 'trackEvent'
          validate_track_attrs!(element)
        end

        post(options)
      end

      def validate_track_attrs!(options)
        errors = []
        required_track_attrs.each do |attr|
          errors << attr unless options[attr].present?
        end
        return if errors.blank?

        raise ChurnZero::Error::RequestError, "Parameters Missing - #{errors.join(', ')}"
      end

      def required_track_attrs
        %i[
          account_external_id
          action
          event_name
        ]
      end
    end
  end
end
