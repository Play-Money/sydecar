module Sydecar
  class FileConnection < BaseConnection
    class << self
      def headers
        common_headers.merge(
          'Content-Type' => 'multipart/form-data',
          'Accept' => '*/*'
        )
      end

      def instance
        super
        return @@instance if @@instance

        @@instance = create_instance(headers, base_url, env, format_of_request: :multipart)
      end
    end

    private

    @@instance = nil

    def initialize
    end
  end
end
