require 'navigable'
require 'rack'
require 'rack/bodyparser'
require 'hanami/router'
require 'json'

require "navigable/graphql/version"
require 'navigable/graphql/application'
require 'navigable/graphql/response'
require 'navigable/graphql/params'
require 'navigable/graphql/request'
require 'navigable/graphql/rack_adapter'
require 'navigable/graphql/basic_resolver'
require 'navigable/graphql/mutation'
require 'navigable/graphql/query'
require 'navigable/graphql/schema'

module Navigable
  module GraphQL
    def self.application
      @application ||= Rack::Builder.new(app) do
        use Rack::BodyParser, :parsers => { 'application/json' => proc { |data| JSON.parse(data) } }
      end
    end

    def self.app
      @app ||= Application.new
    end
  end
end
