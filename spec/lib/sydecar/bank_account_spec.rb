# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::BankAccount do

  before { Sydecar::Connection.token = 'secret-token' }
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:bank_account_id) { 1 }

  it 'calls create' do
    stub_request(:post, "#{Sydecar::BASE_URL}#{Sydecar::BankAccount::CREATE_URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create(body: body)
  end

  it 'calls find' do
    url = "#{Sydecar::BASE_URL}#{Sydecar::BankAccount::URL}#{bank_account_id}?reveal_pii=true&include=spvs"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find(id: bank_account_id)
  end

  it 'calls update' do
    url = "#{Sydecar::BASE_URL}#{Sydecar::BankAccount::URL}#{bank_account_id}"
    stub_request(:patch, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.update(id: bank_account_id, body: {})
  end

  it 'calls find_all' do
    params = {
      sort: 'desc', limit: 1, offset: 1, start_date: '2023-05-01', end_date: '2023-05-31'
    }
    query = '?'
    query += URI.encode_www_form(params)
    url = "#{Sydecar::BASE_URL}#{Sydecar::BankAccount::URL}#{query}"

    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find_all(params: params, body: body)
  end

  it 'calls delete' do
    url = "#{Sydecar::BASE_URL}#{Sydecar::BankAccount::URL}#{bank_account_id}"
    stub_request(:delete, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.delete(id: bank_account_id)
  end

end
