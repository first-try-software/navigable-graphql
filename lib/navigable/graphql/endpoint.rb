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
        parsed_variables.is_a?(Hash) ? parsed_variables : {}
      end

      def parsed_variables
        @parsed_variables ||= JSON.parse(variables) rescue variables
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
