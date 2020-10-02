# frozen_string_literal: true

# custom error for connection related failures, like no internet connection
module ChurnZero
  module Error
    class ConnectionError < StandardError
    end
  end
end