# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::Profile do

  before { Sydecar::Connection.token = 'secret-token' }
  let!(:headers) { Sydecar::Connection.headers }
  let!(:body) { {}.to_json }
  let(:entity_profile_id) { 1 }
  let(:individual_profile_id) { 1 }

  xit 'calls create' do

  end
end
