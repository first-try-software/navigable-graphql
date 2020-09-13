# frozen-string-literal: true

module Navigable
  module GraphQL
    class Application
      def initialize
        router.public_send(:post, '/graphql', to: RackAdapter)
      end

      def call(env)
        router.call(env)
      end

      private

      def router
        @router ||= Hanami::Router.new
      end
    end
  end
end
