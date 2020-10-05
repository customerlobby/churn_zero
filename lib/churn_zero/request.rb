# frozen_string_literal: true

require File.expand_path('errors/connection_error', __dir__)
require File.expand_path('errors/authorization_error', __dir__)

module ChurnZero
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(options = {})
      request(:get, options)
    end

    # Perform an HTTP POST request
    def post(options = {})
      request(:post, options)
    end

    private

    # Perform an HTTP request
    def request(method, options)
      begin
        response = connection.send(method) do |request|
          case method
          when :get
            formatted_options = format_options(options)
            request.url('', formatted_options)
          when :post, :put
            request.headers['Content-Type'] = 'application/json'
            params = options.map { |opt| format_options(opt) }
            request.body = params.to_json unless params.empty?
            request.url('')
          end
        end
      rescue StandardError => e
        # handle connection related failures and raise gem specific standard error
        raise ChurnZero::Error::ConnectionError.new, 'Connection failed.'
      end

      # check the status code
      if response.status == 200
        Response.create(response.body)
      elsif response.status == 401
        raise ChurnZero::Error::AuthorizationError.new, 'Invalid credentials.'
      elsif response.status == 500 && response.body.exceptionMessage.present? && response.body.exceptionMessage =~ /Sequence contains no elements/
        Response.create_empty
      elsif response.status == 504
        raise ChurnZero::Error::ConnectionError.new, 'Connection failed.'
      else
        raise StandardError.new, "Failed to fetch data from ChurnZero, status code: #{response.status}"
      end
    end

    # Format the Options before you send them off to ChurnZero
    def format_options(options)
      return if options.blank?

      options[:app_key] = app_key
      options.transform_keys! { |k| k.to_s.camelize(:lower) }
      options
    end
  end
end
