require 'uri'
require 'connection'

module Sydecar
  class Person
    class << self
      PERSON_URL = '/v1/persons/'.freeze
      CREATE_URL = "#{PERSON_URL}create".freeze

      # @param [Hash] body
      def create(body:)
        Connection.instance.post(CREATE_URL, body.to_json)
      end

      # @param [integer] id
      def find(id:)
        Connection.instance.get("#{PERSON_URL}#{id}", { reveal_pii: true })
      end

      # @param [Integer] id
      # @param [Hash] body
      def update(id:, body:)
        Connection.instance.patch("#{PERSON_URL}#{id}", body.to_json)
      end

      # @param [String] sort
      # @param [Integer] limit
      # @param [Integer] offset
      # @param [String] start_date
      # @param [String] end_date
      def find_all(*params)
        query = '?'
        query += URI.encode_www_form(params)
        Connection.instance.post("#{PERSON_URL}#{query}")
      end
    end
  end
end