# frozen_string_literal: true

module ChurnZero
  # defines version of gem
  class Version
    MAJOR = 0 unless defined? ChurnZero::Version::MAJOR
    MINOR = 1 unless defined? ChurnZero::Version::MINOR
    PATCH = 0 unless defined? ChurnZero::Version::PATCH

    class << self
      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end
    end
  end
end
