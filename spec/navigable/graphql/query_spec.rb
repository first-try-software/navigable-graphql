RSpec.describe Navigable::GraphQL::Query do
  subject(:query) { query_class.send(:new, schema, {}) }

  let(:query_class) do
    Class.new do
      extend Navigable::Command
      corresponds_to :command_key
      def execute
        successfully 'executed command'
      end
    end

    Class.new(GraphQL::Schema::Object) do
      extend Navigable::GraphQL::Query
      field :command_key, String, null: true
    end
  end

  let(:schema) { double('schema') }

  describe 'resolving a query' do
    context 'when the requested field is NOT defined' do
      it 'raises method missing' do
        expect { query.undefined_field }.to raise_error(NoMethodError)
      end

      it 'does not respond to the undefined field' do
        expect(query.respond_to?(:undefined_field)).to be(false)
      end
    end

    context 'when the requested field is defined' do
      it 'executes the command and resolves the query' do
        expect(query.command_key).to eq('executed command')
      end

      it 'responds to the defined field' do
        expect(query.respond_to?(:command_key)).to be(true)
      end
    end
  end
end