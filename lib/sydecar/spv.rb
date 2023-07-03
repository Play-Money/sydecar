# frozen_string_literal: true

module Sydecar
  class Spv
    URL = '/v1/spvs'
    CREATE_URL = "#{URL}/create"
    class << self
      # @param [Hash] body
      def create(body:, idempotency_key:)
        Connection.instance.post(CREATE_URL, body, { 'idempotency-key': idempotency_key })
      end

      # @param [UUID] id
      # @param [Boolean] bank_accounts
      # @param [Boolean] capital_call_events
      # @param [Boolean] dates
      # @param [Boolean] docset
      # @param [Boolean] documents
      # @param [Boolean] expenses
      # @param [Boolean] profile
      # @param [Boolean] subscriptions
      def find(
        id:,
        bank_accounts: false,
        capital_call_events: false,
        dates: false,
        docset: false,
        documents: false,
        expenses: false,
        profile: false,
        subscriptions: false
      )
        query = compile_find_params(
          bank_accounts: bank_accounts,
          capital_call_events: capital_call_events,
          dates: dates,
          docset: docset,
          documents: documents,
          expenses: expenses,
          profile: profile,
          subscriptions: subscriptions
        )

        Connection.instance.get("#{URL}/#{id}", query)
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
      def initiate_close_url(id:)
        "/v1/spvs/#{id}/close/initiate"
      end

      # @param [UUID] id
      # @param [UUID] idempotency_key
      def initiate_close(id:, idempotency_key:)
        url = initiate_close_url(id: id)
        Connection.instance.post(url, nil, { 'idempotency-key': idempotency_key })
      end

      def disburse_close_url(id:)
        "/v1/spvs/#{id}/close/disburse"
      end

      def disburse_close(id:, idempotency_key:)
        url = disburse_close_url(id: id)
        Connection.instance.post(url, nil, { 'idempotency-key': idempotency_key })
      end

      def counter_sign_close_url(id:)
        "/v1/spvs/#{id}/close/counter_sign"
      end

      def counter_sign_close(id:, idempotency_key:)
        url = counter_sign_close_url(id: id)
        Connection.instance.post(url, nil, { 'idempotency-key': idempotency_key })
      end

      def request_approval_url(id:)
        "/v1/spvs/#{id}/request_approval"
      end

      def request_approval(id:, body:)
        url = request_approval_url(id: id)
        Connection.instance.post(url, body)
      end

      def request_bank_account_url(id:)
        "/v1/spvs/#{:id}/request_bank_account"
      end

      def request_bank_account(id:, idempotency_key:)
        url = request_bank_account_url(id: id)
        Connection.instance.post(url, nil, { 'idempotency-key': idempotency_key })
      end

      def disbursements_url(id:)
        "/v1/spvs/#{id}/disbursements"
      end

      def disbursements(id:)
        url = disbursements_url(id: id)
        Connection.instance.get(url)
      end

      def adjust_disbursements_url(id:)
        "/v1/spvs/#{id}/adjust_disbursements"
      end

      def adjust_disbursements(id:, body:)
        url = adjust_disbursements_url(id: id)
        Connection.instance.post(url, body)
      end

      def adjust_fund_deal_investments_url(id:)
        "/v1/spvs/#{id}/adjust_fund_deal_investments"
      end

      def adjust_fund_deal_investments(id:)
        url = adjust_fund_deal_investments_url(id: id)
        Connection.instance.post(url)
      end

      private
      def compile_find_params(
        bank_accounts: false,
        capital_call_events: false,
        dates: false,
        docset: false,
        documents: false,
        expenses: false,
        profile: false,
        subscriptions: false
      )
        include_queries = []
        include_queries << 'bank_accounts' if bank_accounts
        include_queries << 'capital_call_events' if capital_call_events
        include_queries << 'dates' if dates
        include_queries << 'docset' if docset
        include_queries << 'documents' if documents
        include_queries << 'expenses' if expenses
        include_queries << 'profile' if profile
        include_queries << 'subscriptions' if subscriptions

        return {} if include_queries.size.zero?

        { include: include_queries.join(',') }
      end
    end
  end
end