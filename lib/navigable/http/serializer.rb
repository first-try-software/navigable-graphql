# frozen-string-literal: true

module Navigable
  module HTTP
    module Serializer
      TYPE = :__serializer__
      TO_JSON_NOT_IMPLEMENTED_MESSAGE = 'Class must implement `to_json` method.'

      def self.extended(base)
        base.extend(Manufacturable::Item)

        base.instance_eval do
          def serializes(key)
            corresponds_to(key, TYPE)
          end
        end

        base.class_eval do
          attr_reader :data

          def initialize(data:)
            @data = data
          end

          def to_json(*args)
            raise NotImplementedError.new(TO_JSON_NOT_IMPLEMENTED_MESSAGE)
          end
        end
      end
    end
  end
end