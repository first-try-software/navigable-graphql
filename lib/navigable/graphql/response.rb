module Navigable
  module GraphQL
    class InvalidResponse < StandardError; end

    class Response
      HEADERS = { 'Content-Type' => 'application/json' }.freeze
      EMPTY_CONTENT = ''

      attr_reader :params, :status

      def initialize(params)
        @params = params
        @status = params[:status] || 200
      end

      def to_rack_response
        [status, HEADERS, content]
      end

      private

      def content
        [json || EMPTY_CONTENT]
      end

      def json
        return unless params[:json]
        return params[:json].to_s if valid_json?(params[:json])

        params[:json].to_json
      end

      def valid_json?(json)
        JSON.parse(json.to_s)
        return true
      rescue JSON::ParserError => e
        return false
      end
    end
  end
end