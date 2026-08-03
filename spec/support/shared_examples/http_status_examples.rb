# frozen_string_literal: true

shared_examples 'a request that responds with' do |http_code|
  it "responds with HTTP #{http_code}" do
    expect(response).to have_http_status(http_code)
  end
end
