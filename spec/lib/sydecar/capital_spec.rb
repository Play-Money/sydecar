# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Capital do
	let!(:headers) { Sydecar::Connection.headers }
	let!(:body) { {}.to_json }

	it 'calls method fetch_capital_calls_for_SPV' do
		stub_request(:post, "#{Sydecar::Connection.base_url}/#{Sydecar::Capital::CAPITAL_CALL_EVENTS_URL}")
			.with( body: body, headers: headers)
			.to_return(body: body, status: 200)

		subject.class.fetch_capital_calls_for_SPV(params: {}, body: {})
	end
end