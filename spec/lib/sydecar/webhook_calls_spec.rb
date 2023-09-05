# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::WebhookCalls do
	let!(:headers) { Sydecar::Connection.headers}
	let!(:body) { { "url": "string",
	                "label": "string",
	                "token": "string",
	                "disabled": true}.to_json }

	it 'calls register_webhook_callback' do
		stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::WebhookCalls::URL}/create")
			.with(body: body, headers: headers)
			.to_return(body: body, status: 201)

		subject.class.register_webhook_callback(body: body, idempotency_key: 'unique')
	end

	it 'calls fetch_all_webhooks' do
		stub_request(:get, "#{Sydecar::Connection.base_url}#{Sydecar::WebhookCalls::URL}?")
			.with(query: {}, headers: headers)
			.to_return(body: body, status: 200)

		subject.class.fetch_all_webhooks
	end
	#
	# it 'calls fetch_plaid_institutions' do
	# 	stub_request(:get, "#{Sydecar::Connection.base_url}/#{Sydecar::Plaid::PLAID_INSTITUTIONS_URL}")
	# 		.with(body: {}, headers: headers)
	# 		.to_return(body: body, status: 200)
	#
	# 	subject.class.fetch_plaid_institutions()
	# end
	#
	# it 'calls create_plaid_account' do
	# 	stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::Plaid::CREATE_PLAID_BANK_ACCOUNT_URL}")
	# 		.with(body: body, headers: headers)
	# 		.to_return(body: body, status: 201)
	#
	# 	subject.class.create_plaid_account(body: body)
	# end
	#
	# it 'calls reset_plaid_login' do
	# 	stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::Plaid::reset_plaid_login_url(bank_account_id: 'bank_account_id')}")
	# 		.with(headers: headers)
	# 		.to_return(body: body, status: 200)
	#
	# 	subject.class.reset_plaid_login(bank_account_id: 'bank_account_id')
	# end
end
