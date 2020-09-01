# frozen-string-literal: true

module Navigable
  module HTTP
    class Application
      def call(env)
        router.call(env)
      end

      def add_endpoint(verb:, path:, endpoint_class:)
        request_adapter = RackRequestAdapter.new(endpoint_class: endpoint_class)
        routes << { verb: verb, path: path, endpoint: endpoint_class }
        router.public_send(verb, path, to: request_adapter)
      end

      def print_routes
        max_length = routes.map { |route| route[:path].length }.max
        routes.sort_by { |route| route[:path] }.each do |route|
          puts "#{justify(8, 6, route[:verb].upcase)} #{justify(-max_length, max_length, route[:path])} => #{route[:endpoint]}"
        end
      end

      private

      def router
        @router ||= Hanami::Router.new
      end

      def routes
        @routes ||= []
      end

      def justify(max, trunc, string)
        "%#{max}.#{trunc}s" % string
      end
    end
  end
end
