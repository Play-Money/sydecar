# frozen_string_literal: true

module Sydecar
	URL = 'v1/configure/webhooks/'
  class WebhookCalls
    class << self
      # The method create a webhook callback URL
      # @param
      #   HEADER PARAMETERS:
      #     - idempotency-key [String] - Idempotency key header for sensitive operations
      #   REQUEST BODY SCHEMA: application/json
      #     - url [String]       - The callback url associated the the webhook                     (required)
      #     - label [String]     - A label to easily identify your web hook                        (required)
      #     - token [String]     - For security reasons every webhook is associated with a token.  (required)
      #                             This token will be used to sign the incoming payloads.
      #     - disabled [boolean] - Enable / disable your web hook.                             (required)
      #
      # @note
      #   Set a webhook callback URL. You can provide any URL for Sydecar webhook callbacks to land.
      #   All webhook callbacks for the specified environment will be directed to the URL you provide.
      #   For maximum security, make sure to use https endpoints. In addition, webhook calls will be signed with a token.
      #
      # @example
      #   Response samples:
      #   {
      #   "id": "string",
      #   "created_at": "2019-08-24T14:15:22Z",
      #   "updated_at": "2019-08-24T14:15:22Z",
      #   "url": "string",
      #   "label": "string",
      #   "token": "string",
      #   "disabled": true
      # }
      # @return [Hash] - Responses: > '201'
      #
      # See on the https://api-docs.sydecar.io/api/#tag/Configuration/operation/createWebhook
      def create(body:, idempotency_key:)
      	Connection.instance.post("#{URL}create", body, { 'idempotency-key': idempotency_key })
      end

      # This method fetch all webhooks
      # Retrieve all webhooks created to date (filtered). Pagination is available.
      # @param
      #   Query parameters [Hash]
      #   - 'sort' [String] (Enum: 'asc', 'desc')
      #   - 'limit' [Number] (<=100)
      #   - 'offset' [Number]
      #   - 'start_date' [String]
      #   - 'end_date' [String]
      # @example
      # RESPONSE DATA (Sample):
      #   {
      #   "data": [
      #     {
      #       "id": "string",
      #       "created_at": "2019-08-24T14:15:22Z",
      #       "updated_at": "2019-08-24T14:15:22Z",
      #       "url": "string",
      #       "label": "string",
      #       "token": "string",
      #       "disabled": true
      #     }
      #   ],
      #   "pagination": {
      #     "limit": 0,
      #     "offset": 0,
      #     "total": 0
      #   }
      # }
      # @return See example RESPONSES: > '200'
      #
      # See on the hhttps://api-docs.sydecar.io/api/#tag/Configuration/operation/getAllWebhooks
      def fetch_all_webhooks(params:)
      	query = '?'
      	query += URI.encode_www_form(params)
      	Connection.instance.post("#{URL}#{query}")
      end
		end
	end
end
