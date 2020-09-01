# frozen-string-literal: true

module Navigable
  module HTTP
    module Endpoint
      def self.extended(base)
        base.extend(Navigable::Resolver)

        base.instance_eval do
          def responds_to(verb, path)
            Navigable::HTTP.add_endpoint(verb: verb, path: path, endpoint_class: self)
          end

          def executes(command_key)
            @command_key = command_key
          end

          def command_key
            @command_key
          end
        end

        base.class_eval do
          attr_reader :request

          def initialize(request: Request.new)
            @request = request
          end

          def resolve
            @response
          end

          def on_success(data)
            render_json(status: 200, data: data)
          end

          def on_failure_to_validate(data, errors = ["Unprocessable Entity"])
            error = Error.new(messages: errors, source: data)
            render_json(status: 422, data: error)
          end

          def on_failure_to_find(data, errors = ["Not Found"])
            error = Error.new(messages: errors, source: data)
            render_json(status: 404, data: error)
          end

          def on_failure_to_create(data, errors = ["Unable to Create"])
            error = Error.new(messages: errors, source: data)
            render_json(status: 500, data: error)
          end

          def on_failure_to_update(data, errors = ["Unable to Update"])
            error = Error.new(messages: errors, source: data)
            render_json(status: 500, data: error)
          end

          def on_failure_to_delete(data, errors = ["Unable to Delete"])
            error = Error.new(messages: errors, source: data)
            render_json(status: 500, data: error)
          end

          def on_failure(data, errors = [])
            error = Error.new(messages: errors, source: data)
            render_json(status: status, data: error)
          end

          private

          def render_json(status:, data:)
            respond_with status: status, json: Manufacturable.build_one(Serializer::TYPE, data.class, data: data)
          end

          def respond_with(response_params)
            @response = Response.new(response_params)
          end
        end
      end
    end
  end
end