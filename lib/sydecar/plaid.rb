module Sydecar
  class Plaid
    class << self
      CREATE_LINK_TOKEN_URL = 'v1/plaid/create_link_token'
      PLAID_INSTITUTIONS_URL = 'v1/plaid/plaid_institutions'
      CREATE_PLAID_BANK_ACCOUNT_URL = 'v1/plaid/create_plaid_bank_account'
      RESET_PLAID_LOGIN_URL = 'v1/plaid/{bank_account_id}/reset_plaid_login'
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

      # This method creates a bank account using the specified body parameters.
      # @param [Hash] body
      #   - The request body [Hash] with the following keys:
      #   - 'profile_id': [String] (required)
      #   - 'bank_account_id': [String] (optional)
      #     See more details: https://api-docs.sydecar.io/api/#tag/Plaid/operation/createPlaidLinkToken
      #
      # @return [Hash] - application/json -
      #   { link_token: [String], expiration: [String], request_id: [String] }
      #
      #     RESPONSES: > '201'
      def create_link_token(body:)
        Connection.instance.post(CREATE_LINK_TOKEN_URL, body)
      end

      # This method Fetch a list of all available Plaid institutions.
      # @param [Hash] body
      #   QUERY PARAMETERS:
      #   - 'limit': [Number] (<= 500) (optional)
      #   - 'offset': [Number] (optional)
      #     See more details: https://api-docs.sydecar.io/api/#tag/Plaid/operation/setPlaidAccessToken
      # @example
      # Responses sample:
      #   {
      #   "data": [
      #     {
      #       "institution_id": "string",
      #       "name": "string",
      #       "products": [
      #         "assets"
      #       ],
      #       "country_codes": [
      #         "US"
      #       ],
      #       "url": "string",
      #       "primary_color": "string",
      #       "logo": "string",
      #       "routing_numbers": [
      #         "string"
      #       ],
      #       "oauth": true,
      #       "status": {},
      #       "payment_initiation_metadata": {},
      #       "auth_metadata": {}
      #     }
      #   ],
      #   "pagination": {
      #     "limit": 0,
      #     "offset": 0,
      #     "total": 0
      #   }
      # }
      # @return See example data [Hash] Responses : > '200'
      def fetch_plaid_institutions(query = {})
        Connection.instance.get(PLAID_INSTITUTIONS_URL, query)
      end

      # Create a Plaid account without using Plaid link (Sandbox only)
      # @param [Hash] body
      #   - "institution_id": "string", (required)
      #   - "profile_id": "string"      (required)
      #     This method create a Plaid account without using Plaid link (Sandbox only). This route is meant to quickly setup a plaid account for testing.
      #     See https://api-docs.sydecar.io/api/#tag/Plaid/operation/createPlaidPublicToken
      # @Example
      # Response sample (application/json) :
      #   {
      #   "id": "string",
      #   "created_at": "2019-08-24T14:15:22Z",
      #   "updated_at": "2019-08-24T14:15:22Z",
      #   "bank_name": "string",
      #   "account_name": "string",
      #   "type": "STANDARD",
      #   "account_type": "CHECKING",
      #   "is_us_based": true,
      #   "account_number": "string",
      #   "routing_number": "string",
      #   "street_1": "123 Maple Street",
      #   "street_2": "Unit 2",
      #   "city": "Maple Town",
      #   "state": "CA",
      #   "zip_code": "94033",
      #   "country_code": "US",
      #   "for_further_credit": "string",
      #   "profile_ids": [
      #     "string"
      #   ],
      #   "plaid_consent_expiration_time": "2022-10-12T07:30:50.52Z",
      #   "plaid_account_number_mask": "1111",
      #   "plaid_institution_id": "string"
      # }
      #
      # @return See example data [Hash] Responses : > '201'
      def create_plaid_account(body:)
        Connection.instance.post(CREATE_PLAID_BANK_ACCOUNT_URL, body)
      end

      # This method reset a Plaid account's login (Sandbox only)
      # @param [Hash] body
      #   - 'bank_account_id': [String] (required)
      #     Resets the Plaid account's login information forcing the user to reauthenticate. As part of the reset, the 'plaid_consent_expiration_time' attribute is set to yesterday's date. When plaid link is called in update mode the 'plaid_consent_expiration_time' gets set back to the item's value. This route is only available in sandbox.
      #     See https://api-docs.sydecar.io/api/#tag/Plaid/operation/resetPlaidLogin
      # @Example
      # Response sample (application/json) :
      #   {
      #   "id": "string",
      #   "created_at": "2019-08-24T14:15:22Z",
      #   "updated_at": "2019-08-24T14:15:22Z",
      #   "bank_name": "string",
      #   "account_name": "string",
      #   "type": "STANDARD",
      #   "account_type": "CHECKING",
      #   "is_us_based": true,
      #   "account_number": "string",
      #   "routing_number": "string",
      #   "street_1": "123 Maple Street",
      #   "street_2": "Unit 2",
      #   "city": "Maple Town",
      #   "state": "CA",
      #   "zip_code": "94033",
      #   "country_code": "US",
      #   "for_further_credit": "string",
      #   "profile_ids": [
      #     "string"
      #   ],
      #   "plaid_consent_expiration_time": "2022-10-12T07:30:50.52Z",
      #   "plaid_account_number_mask": "1111",
      #   "plaid_institution_id": "string"
      # }
      #
      # @return See example data [Hash] Responses : > '200'
      def reset_plaid_login(body:)
        Connection.instance.post(RESET_PLAID_LOGIN_URL, body)
      end
    end
  end
end
