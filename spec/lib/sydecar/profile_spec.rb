# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Profile do

  before { Sydecar::Connection.token = 'secret-token' }
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:id) { 1 }

  it 'calls find' do
    url = "#{Sydecar::BASE_URL}#{Sydecar::Profile::URL}#{id}?reveal_pii=true&include=subscriptions,spvs"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find(id: id)
  end

  it 'calls activate_spv' do
    url = "#{Sydecar::BASE_URL}#{Sydecar::Profile.activate_spv_url(id: id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.activate_spv(id: id)
  end

  it 'calls deactivate_spv' do
    url = "#{Sydecar::BASE_URL}#{Sydecar::Profile.deactivate_spv_url(id: id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.deactivate_spv(id: id)
  end

  it 'calls find_all' do
    params = {
      sort: 'desc', limit: 1, offset: 1, start_date: '2023-05-01', end_date: '2023-05-31'
    }
    query = '?'
    query += URI.encode_www_form(params)
    url = "#{Sydecar::BASE_URL}#{Sydecar::Profile::URL}#{query}"

    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find_all(params: params, body: body)
  end

  it 'calls accreditation_qualification_opts' do
    url = "#{Sydecar::BASE_URL}#{Sydecar::Profile::ACCREDITATION_QUALIFICATION_URL}"

    stub_request(:post, url)
      .with(body: { sub_type: 'PERSON', entity_type: 'SOLE_PROPRIETOR' }, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.accreditation_qualification_opts(sub_type: 'PERSON', entity_type: 'SOLE_PROPRIETOR')
  end
end
