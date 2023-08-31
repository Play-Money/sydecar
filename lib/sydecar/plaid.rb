module Sydecar
  class Plaid
    class << self
      def create_bank_account_url
        '/v1/plaid/link_plaid_bank_account'
      end

      # body argument expects to have the following keys:
      # [String] profile_id: required
      # [String] public_token: required
      # [Hash] metadata: PlaidLinkOnSuccessMetadata =>
      # {
      #   [Hash or nil] institution: required
      #   [Array of objects (PlaidAccount)] accounts: required
      #   [String] link_session_id: required
      # }
      # See more for details: https://api-docs.sydecar.io/api/#tag/Plaid/operation/setPlaidAccessToken

      def create_bank_account(body:)
        url = create_bank_account_url
        Connection.instance.post(url, body)
      end
    end
  end
end
