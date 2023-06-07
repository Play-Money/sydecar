module Sydecar
  class Connection < BaseConnection
    class << self
      def headers
        common_headers.merge('Content-Type' => 'application/json')
      end

      def instance
        super

        return @@instance if @@instance

        @@instance = Faraday.new(
          url: base_url,
          headers: headers
        ) do |f|
          f.request :json
          f.response :json
          if %w[development].include?(ENV['RAILS_ENV'])
            f.response :logger
          end
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