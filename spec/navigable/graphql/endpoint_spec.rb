RSpec.describe Navigable::GraphQL::Endpoint do
  subject(:endpoint) { described_class.new.tap { |endpoint| endpoint.inject(request: request) } }

  let(:request) { instance_double(Navigable::Server::Request, params: params) }
  let(:params) { { query: query, variables: variables, operationName: operation_name } }
  let(:query) { 'query' }
  let(:variables) { nil }
  let(:operation_name) { 'operation name' }

  it 'configures the correct route' do
    expect(Navigable::Server.router).to match_route(:post, '/graphql', described_class)
  end

  describe '#execute' do
    subject(:execute) { endpoint.execute }

    let(:schema) { instance_double('schema', execute: json) }
    let(:json) { {}.to_json }

    before { allow(Navigable::GraphQL::Schema).to receive(:schema).and_return(schema) }

    it 'executes the query' do
      execute

      expect(schema)
        .to have_received(:execute)
        .with(
          query,
          a_hash_including(
            variables: {},
            context: {},
            operation_name: operation_name
          )
        )
    end

    it 'returns a status code of 200' do
      expect(execute).to include(status: 200)
    end

    it 'returns the results of the query in json' do
      expect(execute).to include(json: '{}')
    end

    context 'when variables are a string' do
      context 'and the string is not valid JSON' do
        let(:variables) { 'Ahoy!' }

        it 'executes the query' do
          execute

          expect(schema)
            .to have_received(:execute)
            .with(
              query,
              a_hash_including(
                variables: {},
                context: {},
                operation_name: operation_name
              )
            )
        end
      end

      context 'and the string is valid JSON' do
        let(:variables) { variable.to_json }
        let(:variable) { { 'variable' => 'value' } }

        it 'executes the query' do
          execute

          expect(schema)
            .to have_received(:execute)
            .with(
              query,
              a_hash_including(
                variables: variable,
                context: {},
                operation_name: operation_name
              )
            )
        end
      end
    end

    context 'when variables are a hash' do
      let(:variables) { variable }
      let(:variable) { { 'variable' => 'value' } }

      it 'executes the query' do
        execute

        expect(schema)
          .to have_received(:execute)
          .with(
            query,
            a_hash_including(
              variables: variable,
              context: {},
              operation_name: operation_name
            )
          )
      end
    end

    context 'when variables are a NOT a string or hash' do
      let(:variables) { ['Ahoy!'] }

      it 'raises an argument error' do
        expect { execute }.to raise_error(ArgumentError)
      end
    end
  end
end