# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :request do
  before { req }

  ## [DN] Example route, action and spec that can be removed
  describe 'GET /api/v1/base' do
    subject(:req) { get api_v1_base_example_path }

    it_behaves_like 'a request that responds with', :no_content
  end
end
