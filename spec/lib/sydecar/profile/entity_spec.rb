# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Profile::Entity do
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:entity_id) { 1 }

  it 'calls create' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::Profile::Entity::URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create(body: body)
  end

  it 'calls update' do
    stub_request(:patch, "#{Sydecar::Connection.base_url}#{Sydecar::Profile::Entity.update_url(id: entity_id)}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.update(id: entity_id, body: body)
  end
end
