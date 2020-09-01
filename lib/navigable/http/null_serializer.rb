# frozen-string-literal: true

module Navigable
  module HTTP
    class NullSerializer
      extend Serializer

      default_manufacturable Serializer::TYPE

      def to_json(*args)
        data.to_json(*args)
      end
    end
  end
end
