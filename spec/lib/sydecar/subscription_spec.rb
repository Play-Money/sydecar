# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Subscription do
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:id) { 1 }

  it 'calls create' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::Subscription::CREATE_URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create(body: body, idempotency_key: 'unique')
  end

  it 'calls funding_countries_list' do
    stub_request(:get, "#{Sydecar::Connection.base_url}#{Sydecar::Subscription::FUNDING_COUNTRIES_URL}")
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.funding_countries_list
  end

  it 'calls find' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription::URL}/#{id}?reveal_bank_info=true&include=ach_transfers"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find(id: id)
  end

  it 'calls update' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription::URL}/#{id}"
    stub_request(:patch, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.update(id: id, body: {})
  end

  it 'calls delete' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription::URL}/#{id}"
    stub_request(:delete, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.delete(id: id)
  end

  it 'calls create_agreement_preview' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription.create_agreement_preview_url(id: id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create_agreement_preview(id: id)
  end

  it 'calls create_virtual_bank_account' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription.create_virtual_bank_account_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create_virtual_bank_account(id: id, body: {})
  end

  it 'calls set_balance' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription.set_balance_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.set_balance(id: id, body: {})
  end

  it 'calls sign' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription.sign_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.sign(id: id, body: {})
  end

  it 'calls amend' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription.amend_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.amend(id: id, body: {})
  end

  it 'calls send_ach_with_plaid' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription.send_ach_with_plaid_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.send_ach_with_plaid(id: id, body: {}, idempotency_key: 'unique')
  end

  it 'calls refund_ach_with_plaid' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription.refund_ach_with_plaid_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.refund_ach_with_plaid(id: id, body: {}, idempotency_key: 'unique')
  end

  it 'calls refund' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Subscription.refund_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.refund(id: id, body: {}, idempotency_key: 'unique')
  end
end
