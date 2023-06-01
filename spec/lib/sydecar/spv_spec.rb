# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Spv do

  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:spv_id) { 1 }

  it 'calls create' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::Spv::CREATE_URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create(body: body)
  end

  it 'calls find' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv::URL}/#{spv_id}"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find(id: spv_id)
  end

  it 'calls find including profile and subscription' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv::URL}/#{spv_id}?include=profile,subscriptions"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find(id: spv_id, profile: true, subscriptions: true)
  end

  it 'calls update' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv::URL}/#{spv_id}"
    stub_request(:patch, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.update(id: spv_id, body: {})
  end

  it 'calls find_all' do
    params = {
      sort: 'desc', limit: 1, offset: 1, start_date: '2023-05-01', end_date: '2023-05-31'
    }
    query = '?'
    query += URI.encode_www_form(params)
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv::URL}#{query}"

    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find_all(params: params, body: body)
  end

  it 'calls initiate_close' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv.initiate_close_url(id: spv_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.initiate_close(id: spv_id, idempotency_key: 'unique-key')
  end

  it 'calls disburse_close' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv.disburse_close_url(id: spv_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.disburse_close(id: spv_id, idempotency_key: 'unique-key')
  end

  it 'calls counter_sign_close' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv.counter_sign_close_url(id: spv_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.counter_sign_close(id: spv_id, idempotency_key: 'unique-key')
  end

  it 'calls request_approval' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv.request_approval_url(id: spv_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.request_approval(id: spv_id, body: body, idempotency_key: 'unique-key')
  end

  it 'calls request_bank_account' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv.request_bank_account_url(id: spv_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.request_bank_account(id: spv_id, idempotency_key: 'unique-key')
  end

  it 'calls disbursements' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv.disbursements_url(id: spv_id)}"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.disbursements(id: spv_id)
  end

  it 'calls adjust_disbursements' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv.adjust_disbursements_url(id: spv_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.adjust_disbursements(id: spv_id, body: body)
  end

  it 'calls adjust_fund_deal_investments' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Spv.adjust_fund_deal_investments_url(id: spv_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.adjust_fund_deal_investments(id: spv_id)
  end
end
