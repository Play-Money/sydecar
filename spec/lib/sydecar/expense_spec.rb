# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Expense do

  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:expense_id) { 1 }

  it 'calls create' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::Expense::CREATE_URL}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create(body: body)
  end

  it 'calls find' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Expense::URL}/#{expense_id}?reveal_pii=true"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find(id: expense_id)
  end

  it 'calls update' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Expense::URL}/#{expense_id}"
    stub_request(:patch, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.update(id: expense_id, body: {})
  end

  it 'calls find_all' do
    params = {
      sort: 'desc', limit: 1, offset: 1, start_date: '2023-05-01', end_date: '2023-05-31'
    }
    query = '?'
    query += URI.encode_www_form(params)
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Expense::URL}#{query}"

    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find_all(params: params, body: body)
  end

  it 'calls delete' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Expense::URL}/#{expense_id}"
    stub_request(:delete, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.delete(id: expense_id)
  end

  it 'calls pay' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Expense.pay_url(id: expense_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.pay(id: expense_id)
  end

  it 'calls cancel' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Expense.cancel_url(id: expense_id)}"
    stub_request(:post, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.cancel(id: expense_id)
  end
end
