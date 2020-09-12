# frozen-string-literal: true

module Navigable
  module GraphQL
    class Error
      attr_reader :messages, :source

      def initialize(messages:, source:)
        @messages, @source = messages, source
      end
    end
  end
end