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
          @result = Navigable::Dispatcher.dispatch(command_key, params: kwargs) if command_key
          super
        end

        private

        def result
          @result
        end

        def command_key
          self.class.instance_variable_get(:@command_key)
        end
      end
    end
  end
end
