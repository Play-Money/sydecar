# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Sydecar::BaseConnection do
  it 'raises TokenNotSetError' do
    expect{ subject.class.instance }.to raise_error(Sydecar::TokenNotSetError)
  end

  it 'raises BaseUrlNotSetError' do
    subject.class.token = 'secret-token'
    expect{ subject.class.instance }.to raise_error(Sydecar::BaseUrlNotSetError)
  end

  it 'does not raise errors' do
    subject.class.token = 'secret-token'
    subject.class.base_url = 'https://testurl.com'
    expect{ subject.class.instance }.to_not raise_error
  end
end
