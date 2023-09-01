# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Plaid do
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }

  it 'calls create_bank_account' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::Plaid::create_bank_account_url}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create_bank_account(body: body)
  end

  it 'calls create_link_token' do
    stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::Plaid::CREATE_LINK_TOKEN_URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 201)

    subject.class.create_link_token(body: body)
  end

  it 'calls fetch_plaid_institutions' do
    stub_request(:get, "#{Sydecar::Connection.base_url}/#{Sydecar::Plaid::PLAID_INSTITUTIONS_URL}")
      .with(body: {}, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.fetch_plaid_institutions(body: {})
  end

  it 'calls create_plaid_account' do
    stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::Plaid::CREATE_PLAID_BANK_ACCOUNT_URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 201)

    subject.class.create_plaid_account(body: body)
  end

  it 'calls reset_plaid_login' do
    stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::Plaid::reset_plaid_login_url('bank_account_id')}")
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.reset_plaid_login(bank_account_id: 'bank_account_id')
  end
end
