# frozen_string_literal: true

# custom error for request related failures
module ChurnZero
  module Error
    class RequestError < StandardError
    end
  end
end