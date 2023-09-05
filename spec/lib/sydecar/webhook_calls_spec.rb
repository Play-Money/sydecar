# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::WebhookCalls do
  let!(:headers) { Sydecar::Connection.headers}
  let!(:body) { { "url": "string",
                    "label": "string",
                    "token": "string",
                    "disabled": true}.to_json }
  let!(:webhook_id) { '1'}
  it 'calls register_webhook_callback' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::WebhookCalls::URL}/create")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 201)
    subject.class.register_webhook_callback(body: body, idempotency_key: 'unique')
  end
  it 'calls fetch_all_webhooks' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::WebhookCalls::URL}")
      .with(headers: headers)
      .to_return(body: body, status: 200)
    subject.class.fetch_all_webhooks
  end
  it 'calls fetch_webhook' do
    stub_request(:get, "#{Sydecar::Connection.base_url}#{Sydecar::WebhookCalls::URL}/#{webhook_id}")
      .with(body: {}, headers: headers)
      .to_return(body: body, status: 200)
    subject.class.fetch_webhook(webhook_id: webhook_id)
  end
  it 'calls update_webhook' do
    stub_request(:patch, "#{Sydecar::Connection.base_url}#{Sydecar::WebhookCalls::URL}/#{webhook_id}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)
    subject.class.update_webhook(body: body, webhook_id: webhook_id)
  end
  it 'calls fetch_latest_webhook_events' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::WebhookCalls::URL}/#{webhook_id}/events")
      .with(headers: headers, query: {})
      .to_return(body: body, status: 200)
    subject.class.fetch_latest_webhook_events(webhook_id: webhook_id)
  end
  it 'calls resend_webhook_event' do
    event_id = 1
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::WebhookCalls::URL}/event/#{event_id}")
      .with(headers: headers, query: {})
      .to_return(body: body, status: 200)
    subject.class.resend_webhook_event(event_id: event_id)
  end
end
