# frozen_string_literal: true

# custom error for authorization related failures
module ChurnZero
  module Error
    class AuthorizationError < StandardError
    end
  end
end
