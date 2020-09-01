require 'navigable'
require 'rack'
require 'rack/accept_media_types'
require 'rack/abstract_format'
require 'rack/bodyparser'
require 'hanami/router'
require 'json'

require "navigable/http/version"
require 'navigable/http/application'
require 'navigable/http/response'
require 'navigable/http/headers'
require 'navigable/http/params'
require 'navigable/http/request'
require 'navigable/http/rack_request_adapter'
require 'navigable/http/serializer'
require 'navigable/http/null_serializer'
require 'navigable/http/error'
require 'navigable/http/endpoint'

module Navigable
  module HTTP
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
