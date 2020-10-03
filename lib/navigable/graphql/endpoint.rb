# frozen-string-literal: true

module Navigable
  module GraphQL
    class Endpoint
      extend Navigable::Server::Endpoint

      responds_to :post, '/graphql'

      def execute
        { status: 200, json: json }
      end

      private

      def json
        schema.execute(
          query,
          variables: processed_variables,
          context: context,
          operation_name: operation_name
        )
      end

      def schema
        Navigable::GraphQL::Schema.schema
      end

      def query
        request.params[:query]
      end

      def processed_variables
        return {} if variables.nil?

        case variables
        when String
          begin
            JSON.parse(variables)
          rescue JSON::ParserError
            {}
          end
        when Hash
          variables
        else
          raise ArgumentError, "Unexpected parameter: #{variables}"
        end
      end

      def variables
        request.params[:variables]
      end

      def context
        {}
      end

      def operation_name
        request.params[:operationName]
      end
    end
  end
end
