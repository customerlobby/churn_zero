# frozen_string_literal: true

module ChurnZero
  # Wrapper for the ChurnZero REST API.
  class Client < API
    Dir[File.expand_path('client/*.rb', __dir__)].each { |f| require f }

    include ChurnZero::Client::Attribute
    include ChurnZero::Client::Event
  end
end
