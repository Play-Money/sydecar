# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::CapitalCall do
	let!(:headers) { Sydecar::Connection.headers }
	let!(:body) { {}.to_json }
	let!(:capital_call_event_id) { '1' }

	it 'calls method fetch_capital_calls_for_spv' do
		stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::CapitalCall::CAPITAL_CALL_EVENTS_URL}")
			.with( body: body, headers: headers)
			.to_return(body: body, status: 200)

		subject.class.fetch_capital_calls_for_spv(params: {}, body: {})
	end

	it 'calls method create_spv_capital_call' do
		stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::CapitalCall::CAPITAL_CALL_EVENTS_URL}/create")
			.with( body: body, headers: headers)
			.to_return(body: body, status: 201)

		subject.class.create_spv_capital_call(body: body, idempotency_key: 'unique')
	end

	it 'calls method fetch_spv_capital_call' do
		stub_request(:get, "#{Sydecar::Connection.base_url}/#{Sydecar::CapitalCall::CAPITAL_CALL_EVENTS_URL}/#{capital_call_event_id}?include=capital_calls")
			.with( headers: headers)
			.to_return(body: body, status: 200)

		subject.class.fetch_spv_capital_call(capital_call_event_id: capital_call_event_id, query: { include: 'capital_calls' })
	end

	it 'calls method update_spv_capital_call' do
		stub_request(:patch, "#{Sydecar::Connection.base_url}/#{Sydecar::CapitalCall::CAPITAL_CALL_EVENTS_URL}/#{capital_call_event_id}")
			.with( body: body, headers: headers)
			.to_return(body: body, status: 201)

		subject.class.update_spv_capital_call(capital_call_event_id: capital_call_event_id, body: body)
	end

	it 'calls method delete_spv_capital_call' do
		stub_request(:delete, "#{Sydecar::Connection.base_url}/#{Sydecar::CapitalCall::CAPITAL_CALL_EVENTS_URL}/#{capital_call_event_id}")
			.with( headers: headers)
			.to_return(body: body, status: 201)

		subject.class.delete_spv_capital_call(capital_call_event_id: capital_call_event_id)
	end

	it 'calls method get_capital_call_for_disbursement' do
		stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::CapitalCall::CAPITAL_CALL_EVENTS_URL}/capital_call_needed_for_disbursement?use_spv_allocation=true")
			.with( body: body, headers: headers)
			.to_return(body: body, status: 201)

		subject.class.get_capital_call_for_disbursement(body: body, query: { use_spv_allocation: true })
	end
end