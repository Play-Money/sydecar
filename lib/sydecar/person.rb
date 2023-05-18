require 'uri'
require 'sydecar/connection'

module Sydecar
  class Person
    PERSON_URL = '/v1/persons/'.freeze
    CREATE_URL = "#{PERSON_URL}create".freeze
    class << self
      # @param [Hash] body
      def create(body:)
        Connection.instance.post(CREATE_URL, body)
      end

      # @param [integer] id
      def find(id:)
        Connection.instance.get("#{PERSON_URL}#{id}", { reveal_pii: true })
      end

      # @param [Integer] id
      # @param [Hash] body
      def update(id:, body:)
        Connection.instance.patch("#{PERSON_URL}#{id}", body)
      end

      # @param [Hash] params argument expects to have the following keys
      # [String] sort: asc / desc
      # [Integer] limit
      # [Integer] offset
      # [String] start_date (format: yyyy-mm-dd)
      # [String] end_date (format: yyyy-mm-dd)
      # @param [Hash] body expects to have "ids" key
      def find_all(params: {}, body: {})
        query = '?'
        query += URI.encode_www_form(params)
        Connection.instance.post("#{PERSON_URL}#{query}", body)
      end

      # @param [Integer] id
      def kyc(id:)
        Connection.instance.post("#{PERSON_URL}#{id}/kyc")
      end
    end
  end
end