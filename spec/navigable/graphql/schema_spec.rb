RSpec.describe Navigable::GraphQL::Schema do
  let!(:schema) do
    Class.new(GraphQL::Schema) do
      extend Navigable::GraphQL::Schema
    end
  end

  describe '.app_schema' do
    it 'returns the extended schema' do
      expect(Navigable::GraphQL::Schema.schema).to eq(schema)
    end
  end
end