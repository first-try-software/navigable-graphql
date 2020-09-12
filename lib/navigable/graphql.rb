require 'navigable'
require 'rack'
require 'rack/accept_media_types'
require 'rack/abstract_format'
require 'rack/bodyparser'
require 'hanami/router'
require 'json'

require "navigable/graphql/version"
require 'navigable/graphql/application'
require 'navigable/graphql/response'
require 'navigable/graphql/headers'
require 'navigable/graphql/params'
require 'navigable/graphql/request'
require 'navigable/graphql/rack_request_adapter'
require 'navigable/graphql/serializer'
require 'navigable/graphql/null_serializer'
require 'navigable/graphql/error'
require 'navigable/graphql/endpoint'

module Navigable
  module GraphQL
    def self.application
      @application ||= Rack::Builder.new(app) do
        use Rack::BodyParser, :parsers => { 'application/json' => proc { |data| JSON.parse(data) } }
        use Rack::AbstractFormat
      end
    end

    def self.app
      @app ||= Application.new
    end

    def self.add_endpoint(**kwargs)
      app.add_endpoint(**kwargs)
    end
  end
end
