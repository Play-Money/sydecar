# frozen_string_literal: true

module Sydecar
  class Subscription
    URL = '/v1/subscriptions'
    CREATE_URL = "#{URL}/create"
    FUNDING_COUNTRIES_URL = '/v1/subscriptions/funding_countries'

    class << self
      # @param [Hash] body
      # @param [UUID] idempotency_key
      def create(body:, idempotency_key:)
        Connection.instance.post(CREATE_URL, body, { 'idempotency-key': idempotency_key })
      end

      def funding_countries_list
        Connection.instance.get(FUNDING_COUNTRIES_URL)
      end

      # @param [UUID] id
      def find(id:)
        Connection.instance.get("#{URL}/#{id}", { reveal_bank_info: true, include: 'ach_transfers' })
      end

      # @param [UUID] id
      # @param [Hash] body
      def update(id:, body:)
        Connection.instance.patch("#{URL}/#{id}", body)
      end

      # @param [UUID] id
      def delete(id:)
        Connection.instance.delete("#{URL}/#{id}")
      end

      # @param [UUID] id
      def create_agreement_preview_url(id:)
        "/v1/subscriptions/#{id}/subscription_agreement/preview?streamable_file=true"
      end

      # @param [UUID] id
      def create_agreement_preview(id:)
        url = create_agreement_preview_url(id: id)
        Connection.instance.post(url)
      end

      # @param [UUID] id
      def create_virtual_bank_account_url(id:)
        "/v1/subscriptions/#{id}/create_account"
      end

      # @param [UUID] id
      # @param [Hash] body
      def create_virtual_bank_account(id:, body:)
        url = create_virtual_bank_account_url(id: id)
        Connection.instance.post(url, body)
      end

      # @param [UUID] id
      def set_balance_url(id:)
        "/v1/subscriptions/#{id}/fund"
      end

      # @param [UUID] id
      # @param [Hash] body
      def set_balance(id:, body:)
        url = set_balance_url(id: id)
        Connection.instance.post(url, body)
      end

      # @param [UUID] id
      def sign_url(id:)
        "/v1/subscriptions/#{id}/sign"
      end

      # @param [UUID] id
      # @param [Hash] body
      def sign(id:, body:)
        url = sign_url(id: id)
        Connection.instance.post(url, body)
      end

      def amend_url(id:)
        "/v1/subscriptions/#{id}/amend"
      end

      # @param [UUID] id
      # @param [Hash] body
      def amend(id:, body:)
        url = amend_url(id: id)
        Connection.instance.post(url, body)
      end

      # @param [UUID] id
      def send_ach_with_plaid_url(id:)
        "/v1/subscriptions/#{id}/send_ach_with_plaid"
      end

      # @param [UUID] id
      # @param [Hash] body
      # @param [UUID] idempotency_key
      def send_ach_with_plaid(id:, body:, idempotency_key:)
        url = send_ach_with_plaid_url(id: id)
        Connection.instance.post(url, body, { 'idempotency-key': idempotency_key })
      end

      # @param [UUID] id
      def refund_ach_with_plaid_url(id:)
        "/v1/subscriptions/#{id}/refund_ach_with_plaid"
      end

      # @param [UUID] id
      # @param [Hash] body
      # @param [UUID] idempotency_key
      def refund_ach_with_plaid(id:, body:, idempotency_key:)
        url = refund_ach_with_plaid_url(id: id)
        Connection.instance.post(url, body, { 'idempotency-key': idempotency_key })
      end

      # @param [UUID] id
      def refund_url(id:)
        "/v1/subscriptions/#{id}/refund"
      end

      # @param [UUID] id
      # @param [Hash] body
      # @param [UUID] idempotency_key
      def refund(id:, body:, idempotency_key:)
        url = refund_url(id: id)
        Connection.instance.post(url, body, { 'idempotency-key': idempotency_key })
      end

      # @param [Hash] params argument expects to have the following keys:
      # [String] sort: asc / desc
      # [Integer] limit
      # [Integer] offset
      # [String] start_date (format: yyyy-mm-dd)
      # [String] end_date (format: yyyy-mm-dd)
      # [Boolean] reveal_bank_info
      # [String] include (example: {include: 'ach_transfers'})
      # @param [Hash] body: expects to have "ids" key
      def find_all(params: {}, body: {})
        query = '?'
        query += URI.encode_www_form(params)
        Connection.instance.post("#{URL}#{query}", body)
      end

      def finalize_url(subscription_id)
        "#{URL}/#{subscription_id}/finalize"
      end

      # @param
      # 'subscription_id' [String] id of subscriber
      # "document_signer": { "name": [String],
      #                      "title": [String] }
      #   "name"  The name of the signer.
      #   "title"  The title of the signer as relates to the entity it represents.
      #
      # Finalize a subscription to be ready to create a bank account.
      def finalize(subscription_id:, body:)
        url = finalize_url subscription_id
        Connection.instance.post(url, body)
      end
    end
  end
end