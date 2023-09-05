# frozen_string_literal: true

module Sydecar
  class WebhookCalls
    URL = '/v1/configure/webhooks'
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
      def register_webhook_callback(body:, idempotency_key:)
      	Connection.instance.post("#{URL}/create", body, { 'idempotency-key': idempotency_key })
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
      # See on the https://api-docs.sydecar.io/api/#tag/Configuration/operation/getAllWebhooks
      def fetch_all_webhooks(query: {})
        query = "?#{URI.encode_www_form(query)}"
        Connection.instance.post("#{URL}#{query}")
      end

      # This method Fetch webhook information by id
      # Fetch webhook information by id. This does not include the associate webhook events.
      # @param
      #   PATH PARAMETERS
      #   - webhook_id [String] (required)
      # Response samples
      #   {
      #   "id": "string",
      #   "created_at": "2019-08-24T14:15:22Z",
      #   "updated_at": "2019-08-24T14:15:22Z",
      #   "url": "string",
      #   "label": "string",
      #   "token": "string",
      #   "disabled": true
      # }
      # return [Hash] Responses: > '200'
      #
      # See on the https://api-docs.sydecar.io/api/#tag/Configuration/operation/getWebhook
      def fetch_webhook(webhook_id:)
        Connection.instance.get("#{URL}/#{webhook_id}")
      end

      # This method Update a webhook
      # Update a webhook. You can update the label, url and/or token.
      # @param
      #   PATH PARAMETERS
      #   - webhook_id [String] (required)
      #   REQUEST BODY SCHEMA: application/json
      #     - url [String]       - The callback url associated the the webhook                     (required)
      #     - label [String]     - A label to easily identify your web hook                        (required)
      #     - token [String]     - For security reasons every webhook is associated with a token.  (required)
      #                             This token will be used to sign the incoming payloads.
      #     - disabled [boolean] - Enable / disable your web hook.                             (required)
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
      # @return [Hash] - Responses: > '200'
      #
      # See on the https://api-docs.sydecar.io/api/#tag/Configuration/operation/updateWebhook
      def update_webhook(webhook_id:, body:)
        Connection.instance.patch("#{URL}/#{webhook_id}", body)
      end

      # This method Fetch latest webhook events
      # Fetch the latest events for a webhook.
      # @param
      #   PATH PARAMETERS
      #   - webhook_id [String] (required)
      #   Query parameters [Hash]
      #   - 'sort' [String] (Enum: 'asc', 'desc')
      #   - 'limit' [Number] (<=100)
      #   - 'offset' [Number]
      #   - 'start_date' [String]
      #   - 'end_date' [String]
      # @example
      # RESPONSE DATA (Sample):
      # {
      #   "data": [
      #     {
      #       "id": "string",
      #       "created_at": "2019-08-24T14:15:22Z",
      #       "updated_at": "2019-08-24T14:15:22Z",
      #       "type": "plaid.account.item.expiring",
      #       "details": {
      #         "property1": "string",
      #         "property2": "string"
      #       }
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
      # See on the https://api-docs.sydecar.io/api/#tag/Configuration/operation/getAllWebhookEvents
      def fetch_latest_webhook_events(webhook_id:, query: {})
        query = URI.encode_www_form(query)
        Connection.instance.post("#{URL}/#{webhook_id}/events?#{query}")
      end

      # This method Resend webhook event
      # Resend a webhook event which was previously published.
      # @param
      #   PATH PARAMETERS
      #   - event_id [String] (required)
      # @example
      #   Response samples
      #   {
      #   "id": "string",
      #   "created_at": "2019-08-24T14:15:22Z",
      #   "updated_at": "2019-08-24T14:15:22Z",
      #   "type": "plaid.account.item.expiring",
      #   "details": {
      #     "property1": "string",
      #     "property2": "string"
      #   }
      # }
      # @return [Hash] Responses > '200'
      #
      # See on the https://api-docs.sydecar.io/api/#tag/Configuration/operation/replayWebhookEvent
      def resend_webhook_event(event_id:)
	      Connection.instance.post("#{URL}/event/#{event_id}")
      end
		end
	end
end
