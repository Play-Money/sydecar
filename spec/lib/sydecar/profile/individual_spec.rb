# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Profile::Individual do
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:individual_id) { 1 }

  it 'calls create' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::Profile::Individual::URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create(body: body)
  end
end
