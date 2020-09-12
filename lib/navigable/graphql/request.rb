# frozen-string-literal: true

module Navigable
  module GraphQL
    class Request
      def initialize(env = nil)
        @env = env
      end

      def headers
        @headers ||= @env ? Headers.new(@env).to_h : {}
      end

      def params
        @params ||= @env ? Params.new(@env).to_h : {}
      end
    end
  end
end