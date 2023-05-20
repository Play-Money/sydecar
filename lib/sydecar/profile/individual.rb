# frozen_string_literal: true
require 'sydecar/connection'

module Sydecar
  class Profile
    class Individual
      URL = '/v1/profiles/individual'.freeze

      class << self
        # @param [Hash] body
        def create(body:)
          Connection.instance.post(URL, body)
        end
      end
    end
  end
end