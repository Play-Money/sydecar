# frozen_string_literal: true

module Sydecar
  class Entity
    URL = '/v1/entities'
    CREATE_URL = "#{URL}/create"
    class << self
      # @param [Hash] body
      def create(body:)
        Connection.instance.post(CREATE_URL, body)
      end

      # @param [UUID] id
      def find(id:)
        Connection.instance.get("#{URL}/#{id}", { reveal_pii: true })
      end

      # @param [UUID] id
      # @param [Hash] body
      def update(id:, body:)
        Connection.instance.patch("#{URL}/#{id}", body)
      end

      # @param [Hash] params argument expects to have the following keys
      # [String] sort: asc / desc
      # [Integer] limit
      # [Integer] offset
      # [String] start_date (format: yyyy-mm-dd)
      # [String] end_date (format: yyyy-mm-dd)
      # @param [Hash] body: expects to have "ids" key
      def find_all(params: {}, body: {})
        query = '?'
        query += URI.encode_www_form(params)
        Connection.instance.post("#{URL}#{query}", body)
      end
    end
  end
end