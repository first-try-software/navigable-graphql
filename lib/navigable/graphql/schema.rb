module Navigable
  module GraphQL
    module Schema
      def self.extended(base)
        @schema = base
      end

      def self.schema
        @schema
      end
    end
  end
end