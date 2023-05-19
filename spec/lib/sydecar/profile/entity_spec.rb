# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Profile::Entity do

  before { Sydecar::Connection.token = 'secret-token' }
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:entity_id) { 1 }

  it 'calls create' do
    stub_request(:post, "#{Sydecar::BASE_URL}#{Sydecar::Profile::Entity::URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    # TODO: discuss if this a good idea to use this kind of checks
    # cons: in this case the test knows too much about the internal implementation which is a bad practice
    # pros: we are able to control that endpoint is still triggered
    # expect(Sydecar::Connection.instance).to receive(:post).with("#{Sydecar::Profile::URL}", body)

    subject.class.create(body: body)
  end

  it 'calls update' do
    stub_request(:patch, "#{Sydecar::BASE_URL}#{Sydecar::Profile::Entity.update_url(id: entity_id)}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.update(id: entity_id, body: body)
  end
end
