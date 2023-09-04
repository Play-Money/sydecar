# frozen_string_literal: true

module Sydecar
	CREATE_URL = 'v1/configure/webhooks/create'
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
			def create(body:, idempotency_key:)
				Connection.instance.post(CREATE_URL, body, { 'idempotency-key': idempotency_key })
			end
		end
	end
end
