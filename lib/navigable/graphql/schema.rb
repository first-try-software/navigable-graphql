module Navigable
  module GraphQL
    module Schema
      def self.extended(base)
        @app_schema = base
      end

      def self.app_schema
        @app_schema
      end
    end
  end
end