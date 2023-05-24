# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Document do
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:id) { 1 }

  it 'calls find' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Document::URL}/#{id}?include=fund"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.find(id: id)
  end

  it 'calls delete' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Document::URL}/#{id}"
    stub_request(:delete, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.delete(id: id)
  end

  it 'calls preview' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Document.preview_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.preview(id: id, body: {})
  end

  it 'calls sign' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Document.sign_url(id: id)}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.sign(id: id, body: {})
  end

  it 'calls required_fields' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Document.required_fields_url(id: id)}"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.required_fields(id: id)
  end

  it 'calls sign_arbitrary' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Document::SIGN_ARBITRARY_URL}"
    stub_request(:post, url)
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.sign_arbitrary(body: {}, idempotency_key: 'unique')
  end

  it 'calls download' do
    url = "#{Sydecar::Connection.base_url}#{Sydecar::Document.download_url(id: id)}"
    stub_request(:get, url)
      .with(headers: headers)
      .to_return(body: body, status: 200)

    subject.class.download(id: id)
  end
end
