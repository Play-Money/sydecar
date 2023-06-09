module Sydecar
  class Connection < BaseConnection
    class << self
      def headers
        common_headers.merge('Content-Type' => 'application/json')
      end

      def instance
        super
        return @@instance if @@instance

        @@instance = create_instance(headers, base_url, env, format_of_request: :json)
      end
    end

    private

    @@instance = nil

    def initialize
    end
  end
end
