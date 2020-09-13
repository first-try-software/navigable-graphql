# frozen-string-literal: true

module Navigable
  module GraphQL
    class RackAdapter
      def self.call(env)
        params = Params.new(env).to_h
        json = Request.new(params).execute

        Response.new(json: json).to_rack_response
      end
    end
  end
end
