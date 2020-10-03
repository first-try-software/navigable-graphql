module Navigable
  module GraphQL
    module Query
      def self.extended(base)
        base.instance_variable_set(:@command_keys, [])
        base.extend(ClassMethods)
        base.prepend(InstanceMethods)
      end

      module ClassMethods
        def field(*args, **kwargs)
          @command_keys << args.first
          super
        end
      end

      module InstanceMethods
        def method_missing(method, *args, **kwargs, &block)
          if field_exists?(method)
            Navigable::Dispatcher.dispatch(method, params: kwargs)
          else
            super
          end
        end

        def respond_to_missing?(m, *)
          field_exists?(m) || super
        end

        private

        def field_exists?(field)
          self.class.instance_variable_get(:@command_keys).include?(field)
        end
      end
    end
  end
end
