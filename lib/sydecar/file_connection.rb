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

        @@instance = Faraday.new(
          url: base_url,
          headers: headers
        ) do |f|
          f.request :multipart
          f.response :json
          if ENV['RAILS_ENV'] == 'development' || !ENV['RAILS_ENV']
            f.response :logger,
                       ActiveSupport::Logger.new($stdout),
                       formatter: Faraday::Logging::ColorFormatter
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
