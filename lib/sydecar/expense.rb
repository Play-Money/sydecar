# frozen_string_literal: true

module Sydecar
  class Expense
    URL = '/v1/expenses'
    CREATE_URL = "#{URL}/create"

    class << self
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

      # @param [UUID] id
      def delete(id:)
        Connection.instance.delete("#{URL}/#{id}")
      end

      def pay_url(id:)
        "/v1/expenses/#{id}/pay"
      end

      def pay(id:)
        url = pay_url(id: id)
        Connection.instance.post(url)
      end

      def cancel_url(id:)
        "/v1/expenses/#{id}/cancel"
      end

      def cancel(id:)
        url = cancel_url(id: id)
        Connection.instance.post(url)
      end
    end
  end
end