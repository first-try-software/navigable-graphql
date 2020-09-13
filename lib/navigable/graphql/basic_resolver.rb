module Navigable
  module GraphQL
    class BasicResolver
      extend Navigable::Resolver

      ERRORS = {
        unprocessable_entity: 'Unprocessable Entity',
        not_found: 'Not Found',
        unable_to_create: 'Unable to Create',
        unable_to_update: 'Unable to Update',
        unable_to_delete: 'Unable to Delete',
        server_error: 'Server Error'
      }.freeze

      def resolve
        @result
      end

      def on_success(data)
        @result = data
      end

      def on_failure_to_validate(data, error = ERRORS[:unprocessable_entity])
        @result = data
      end

      def on_failure_to_find(data, error = ERRORS[:not_found])
        @result = data
      end

      def on_failure_to_create(data, error = ERRORS[:unable_to_create])
        @result = data
      end

      def on_failure_to_update(data, error = ERRORS[:unable_to_update])
        @result = data
      end

      def on_failure_to_delete(data, error = ERRORS[:unable_to_delete])
        @result = data
      end

      def on_failure(data, error = ERRORS[:server_error])
        @result = data
      end
    end
  end
end
