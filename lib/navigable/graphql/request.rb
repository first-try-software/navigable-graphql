module Navigable
  module GraphQL
    class Request
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def execute
        schema.execute(
          query,
          variables: processed_variables,
          context: context,
          operation_name: operation_name
        )
      end

      private

      def schema
        Navigable::GraphQL::Schema.app_schema
      end

      def query
        params[:query]
      end

      def processed_variables
        return {} if variables.nil? || variables.empty?

        case variables
        when String
          JSON.parse(variables) || {}
        when Hash
          variables
        else
          raise ArgumentError, "Unexpected parameter: #{variables}"
        end
      end

      def variables
        params[:variables]
      end

      def context
        {}
      end

      def operation_name
        params[:operationName]
      end
    end
  end
end
