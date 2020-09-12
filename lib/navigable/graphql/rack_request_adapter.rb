# frozen-string-literal: true

module Navigable
  module GraphQL
    class RackRequestAdapter
      attr_reader :endpoint_class

      def initialize(endpoint_class:)
        @endpoint_class = endpoint_class
      end

      def call(env)
        request = request(env)
        response(request).to_rack_response
      end

      def request(env)
        Request.new(env)
      end

      def response(request)
        endpoint = endpoint_class.new(request: request)
        Dispatcher.dispatch(endpoint_class.command_key, params: request.params, resolver: endpoint)
      end
    end
  end
end
