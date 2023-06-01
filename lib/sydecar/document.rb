# frozen_string_literal: true

module Sydecar
  class Document
    URL = '/v1/documents'
    UPLOAD_URL = "#{URL}/upload"
    SIGN_ARBITRARY_URL = '/v1/documents/click-sign?streamable_file=true'
    class << self
      # @param [UUID] id
      def find(id:)
        Connection.instance.get("#{URL}/#{id}")
      end
      # @param [UUID] id
      def delete(id:)
        Connection.instance.delete("#{URL}/#{id}")
      end

      # @param [UUID] id
      def preview_url(id:)
        "/v1/documents/#{id}/preview?streamable_file=false"
      end

      # @param [UUID] id
      # @param [Hash] body
      def preview(id:, body:)
        url = preview_url(id: id)
        Connection.instance.post(url, body)
      end

      # @param [UUID] id
      def sign_url(id:)
        "/v1/documents/#{id}/click-sign?streamable_file=false"
      end

      # @param [UUID] id
      # @param [Hash] body
      def sign(id:, body:)
        url = sign_url(id: id)
        Connection.instance.post(url, body)
      end

      # @param [UUID] id
      def required_fields_url(id:)
        "/v1/documents/#{id}/fields"
      end

      # @param [UUID] id
      def required_fields(id:)
        url = required_fields_url(id: id)
        Connection.instance.get(url)
      end

      def sign_arbitrary(body:, idempotency_key:)
        Connection.instance.post(SIGN_ARBITRARY_URL, body, { 'idempotency-key': idempotency_key })
      end

      # @param [Hash] params argument expects to have the following keys:
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

      def download_url(id:)
        "/v1/documents/#{id}/get_download_url"
      end

      def download(id:)
        url = download_url(id: id)
        Connection.instance.get(url)
      end

      def upload(body:, idempotency_key:)
        FileConnection.instance.post(UPLOAD_URL, body, { 'idempotency-key': idempotency_key })
      end
    end
  end
end