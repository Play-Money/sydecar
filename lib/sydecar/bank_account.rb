require 'uri'
require 'sydecar/connection'

module Sydecar
  class BankAccount
    URL = '/v1/bank_accounts'.freeze
    CREATE_URL = "#{URL}create".freeze
    class << self
      # @param [Hash] body
      def create(body:)
        Connection.instance.post(CREATE_URL, body)
      end

      # @param [integer] id
      def find(id:)
        Connection.instance.get("#{URL}#{id}", { reveal_pii: true, include: 'spvs' })
      end

      # @param [Integer] id
      # @param [Hash] body
      def update(id:, body:)
        Connection.instance.patch("#{URL}#{id}", body)
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

      # @param [integer] id
      def delete(id:)
        Connection.instance.delete("#{URL}#{id}")
      end
    end
  end
end