# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Capital do
	let!(:headers) { Sydecar::Connection.headers }
	let!(:body) { {}.to_json }
	let!(:capital_call_event_id) { '1' }

	it 'calls method fetch_capital_calls_for_SPV' do
		stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::Capital::CAPITAL_CALL_EVENTS_URL}")
			.with( body: body, headers: headers)
			.to_return(body: body, status: 200)

		subject.class.fetch_capital_calls_for_SPV(params: {}, body: {})
	end

	it 'calls method create_SPV_capital_call' do
		stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::Capital::CAPITAL_CALL_EVENTS_URL}/create")
			.with( body: body, headers: headers)
			.to_return(body: body, status: 201)

		subject.class.create_SPV_capital_call(body: body, idempotency_key: 'unique')
	end

	it 'calls method fetch_SPV_capital_call' do
		stub_request(:get, "#{Sydecar::Connection.base_url}/#{Sydecar::Capital::CAPITAL_CALL_EVENTS_URL}/#{capital_call_event_id}?include=capital_calls")
			.with( headers: headers)
			.to_return(body: body, status: 200)

		subject.class.fetch_SPV_capital_call(capital_call_event_id: capital_call_event_id, query: { include: 'capital_calls' })
	end
end