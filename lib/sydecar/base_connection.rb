module Sydecar
  class BaseConnection
    class << self
      attr_accessor :token, :base_url

      def common_headers
        {
          'Authorization' => "Bearer #{token}",
          'User-Agent' => 'Faraday',
          'Connection' => 'keep-alive',
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
      end
    end
  end
end
