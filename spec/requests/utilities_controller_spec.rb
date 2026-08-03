# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UtilitiesController, type: :request do
  before { req }

  describe 'GET /' do
    subject(:req) { get root_path }

    it_behaves_like 'a request that responds with', :ok
  end

  describe 'GET /health' do
    subject(:req) { get health_path }

    it_behaves_like 'a request that responds with', :ok
    it 'responds with expected json' do
      expect(indifferent_body(response)).to include(status: 'Healthy')
    end
  end

  describe '*unmatched' do
    context 'when using GET' do
      subject(:req) { get '/random_path_to_trigger_unmatched' }

      it_behaves_like 'a request that responds with', :not_found
      it 'responds with expected json' do
        expect(indifferent_body(response)).to include(status: 'Not Found')
      end
    end

    context 'when using POST' do
      subject(:req) { post '/random_path/with_subpaths/triggers_unmatched' }

      it_behaves_like 'a request that responds with', :not_found
    end
  end
end
