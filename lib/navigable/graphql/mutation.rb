module Navigable
  module GraphQL
    module Mutation
      def executes(command_key)
        @command_key = command_key
      end

      def self.extended(base)
        base.prepend(InstanceMethods)
      end

      module InstanceMethods
        def resolve(**kwargs)
          @result = Navigable::Dispatcher.dispatch(
            self.class.instance_variable_get(:@command_key),
            params: kwargs,
            resolver: BasicResolver.new
          )
          super
        end
      end
    end
  end
end
