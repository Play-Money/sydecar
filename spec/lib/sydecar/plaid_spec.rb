# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Plaid do
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }

  it 'calls create_bank_account' do
    stub_request(:post, "#{Sydecar::Connection.base_url}#{Sydecar::Plaid::create_bank_account_url}")
      .with(body: body, headers: headers)
      .to_return(body: body, status: 200)

    subject.class.create_bank_account(body:)
  end
end
