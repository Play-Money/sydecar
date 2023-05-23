module Sydecar
  class Connection
    class << self
      attr_accessor :token, :base_url

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

        unless base_url
          raise BaseUrlNotSetError
        end

        return @@instance if @@instance

        @@instance = Faraday.new(
          url: base_url,
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