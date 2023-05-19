# frozen_string_literal: true
require 'sydecar/connection'

module Sydecar
  class Profile
    class Entity
      URL = '/v1/profiles/entity'

      class << self
        # @param [Hash] body
        def create(body:)
          Connection.instance.post(URL, body)
        end

        def update(id:, body:)
          Connection.instance.patch(update_url(id: id), body)
        end

        def update_url(id:)
          "/v1/profiles/#{id}/entity"
        end
      end
    end
  end
end