module Sydecar
  class BaseConnection
    class << self
      attr_accessor :token, :base_url, :env

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

      protected

      def create_instance(headers, base_url, env, format_of_request: :json)
        Faraday.new(url: base_url, headers: headers) do |f|
          f.request format_of_request
          f.response :json
          f.response :logger if %w[development].include?(env)
        end
      end
    end
  end
end
