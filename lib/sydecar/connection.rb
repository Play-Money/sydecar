module Sydecar
  class Connection
    class << self
      attr_accessor :token

      def headers
        {
          'Authorization' => "Bearer #{token}",
          'User-Agent' => 'Faraday',
          'Connection' => 'keep-alive',
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
        }
      end
      def instance
        unless token
          raise TokenNotSetError
        end

        return @@instance if @@instance

        @@instance = Faraday.new(
          url: BASE_URL,
          headers: headers
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