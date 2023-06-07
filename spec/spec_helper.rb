# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:default, :development)
require 'webmock/rspec'
require 'faraday'
require 'sydecar'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    Sydecar::Connection.token = 'secret-token'
    Sydecar::Connection.base_url = 'https://secret.sydecar.api.io'
  end
end
