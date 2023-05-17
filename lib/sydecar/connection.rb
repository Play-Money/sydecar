require 'faraday'

module Sydecar
  class Connection
    class << self
      attr_accessor :token
      def instance

        unless token
          raise TokenNotSetError
        end

        return instance if instance

        @@instance = Faraday.new(
          url: BASE_URL,
          headers: {
            'Authorization' => "Bearer #{token}",
            'User-Agent' => 'Faraday',
            'Connection' => 'keep-alive',
            'Content-Type' => 'application/json',
            'Accept' => 'application/json',
          }
        ) do |f|
          f.request :json
          f.response :json
        end

        @@instance
      end
    end

    private

    @@instance = nil

    def initialize
    end

  end
end