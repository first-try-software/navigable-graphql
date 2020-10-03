RSpec.describe Navigable::GraphQL::Mutation do
  subject(:mutation) { mutation_class.new(object: object, context: context, field: field) }

  let(:object) { instance_double('object') }
  let(:context) { instance_double('context') }
  let(:field) { instance_double('field') }

  describe 'resolving a mutation' do
    context 'when the mutation does NOT execute a command' do
      let(:mutation_class) do
        Class.new(GraphQL::Schema::Mutation) do
          extend Navigable::GraphQL::Mutation

          def resolve(**kwargs)
            { result: 'hard-coded response' }
          end
        end
      end

      it 'resolves the mutation' do
        expect(mutation.resolve).to eq({ result: 'hard-coded response' })
      end
    end

    context 'when the mutation executes a command' do
      let(:mutation_class) do
        Class.new do
          extend Navigable::Command
          corresponds_to :command_key
          def execute
            successfully 'executed command'
          end
        end

        Class.new(GraphQL::Schema::Mutation) do
          extend Navigable::GraphQL::Mutation
          executes :command_key
          def resolve(**kwargs)
            { result: result }
          end
        end
      end

      it 'executes the command and resolves the mutation' do
        expect(mutation.resolve).to eq({ result: 'executed command' })
      end
    end
  end
end