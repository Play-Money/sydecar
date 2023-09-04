# frozen_string_literal: true

module Sydecar
  class Capital

    CAPITAL_CALL_EVENTS_URL = 'v1/capital_call_events'
    class << self
      # Fetch all capital call events for an SPV
  	  # @param
  	  #   Query parameters [Hash]
  	  #   - 'sort' [String] (Enum: 'asc', 'desc')
  	  #   - 'limit' [Number] (<=100)
  	  #   - 'offset' [Number]
  	  #   - 'start_date' [String]
  	  #   - 'end_date' [String]
  	  #   - 'include' [String] (Value: 'capital_calls')
  	  #   REQUEST BODY SCHEMA: application/json
  	  #   - 'ids' [Array of string]
  	  # @example
  	  # RESPONSE DATA (Sample):
  	  #   {
  	  #   "data": [
  	  #     {
  	  #       "id": "string",
  	  #       "created_at": "2019-08-24T14:15:22Z",
  	  #       "updated_at": "2019-08-24T14:15:22Z",
  	  #       "spv_id": "string",
  	  #       "memo": "string",
  	  #       "percentage": 0,
  	  #       "capital_calls": [
  	  #         {
  	  #           "id": "string",
  	  #           "created_at": "2019-08-24T14:15:22Z",
  	  #           "updated_at": "2019-08-24T14:15:22Z",
  	  #           "amount": 0,
  	  #           "amount_funded": 0,
  	  #           "due_date": "2019-08-24T14:15:22Z",
  	  #           "stage": "CREATED",
  	  #           "subscription_id": "string",
  	  #           "capital_call_event_id": "string"
  	  #         }
  	  #       ]
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
		  # See on the https://api-docs.sydecar.io/api/#tag/Capital-Call-Management/operation/getAllCapitalCallEvents
  	  def fetch_capital_calls_for_SPV(params: {}, body: {})
  	   query = '?'
  	   query += URI.encode_www_form(params)
  	   Connection.instance.post("#{CAPITAL_CALL_EVENTS_URL}#{query}", body)
	    end
  	  # This method create an SPV capital call event
		  # @param
		  #   HEADER PARAMETERS:
		  #   - idempotency-key [String]
		  #   REQUEST BODY SCHEMA: application/json
		  #   - {
		  #   "capital_call_events": [ (required)
		  #     {
		  #       "percentage": 100,   (required 0..100)
		  #       "memo": "string"
		  #     }
		  #   ],
		  #   "spv_id": "string"       (required)
		  # }
		  #     - Create one or more capital call events. A valid SPV id is needed.
		  # @example
		  #   RESPONSE SAMPLE
		  #   {
		  #   "data": [
		  #     {
		  #       "id": "string",
		  #       "created_at": "2019-08-24T14:15:22Z",
		  #       "updated_at": "2019-08-24T14:15:22Z",
		  #       "spv_id": "string",
		  #       "memo": "string",
		  #       "percentage": 0,
		  #       "capital_calls": [
		  #         {
		  #           "id": "string",
		  #           "created_at": "2019-08-24T14:15:22Z",
		  #           "updated_at": "2019-08-24T14:15:22Z",
		  #           "amount": 0,
		  #           "amount_funded": 0,
		  #           "due_date": "2019-08-24T14:15:22Z",
		  #           "stage": "CREATED",
		  #           "subscription_id": "string",
		  #           "capital_call_event_id": "string"
		  #         }
		  #       ]
		  #     }
		  #   ]
		  # }
		  # More detail see on the
		  # https://api-docs.sydecar.io/api/#tag/Capital-Call-Management/operation/createOneOrMoreCapitalCallEvents
		  # @return [Hash] Responses: > '201'
		  def create_SPV_capital_call(body:, idempotency_key:)
		   Connection.instance.post("#{CAPITAL_CALL_EVENTS_URL}/create", body, { 'idempotency-key': idempotency_key })
		  end
  	  # Fetch an SPV capital call event by id
		  # @param
		  #   PATH PARAMETERS
		  #   - 'capital_call_event_id' [String] (required)
		  #   QUERY PARAMETERS
		  #   - 'include' [String] (Value: "capital_calls")
		  # @EXAMPLE
		  #   Response samples:
		  #   {
		  #   "id": "string",
		  #   "created_at": "2019-08-24T14:15:22Z",
		  #   "updated_at": "2019-08-24T14:15:22Z",
		  #   "spv_id": "string",
		  #   "memo": "string",
		  #   "percentage": 0,
		  #   "capital_calls": [
		  #     {
		  #       "id": "string",
		  #       "created_at": "2019-08-24T14:15:22Z",
		  #       "updated_at": "2019-08-24T14:15:22Z",
		  #       "amount": 0,
		  #       "amount_funded": 0,
		  #       "due_date": "2019-08-24T14:15:22Z",
		  #       "stage": "CREATED",
		  #       "subscription_id": "string",
		  #       "capital_call_event_id": "string"
		  #     }
		  #   ]
		  # }
		  # @return [Hash] see example
		  #   Response: > '200'
		  def fetch_SPV_capital_call(capital_call_event_id:, query: {})
		   query = "?#{URI.encode_www_form(query)}"
		   Connection.instance.get("#{CAPITAL_CALL_EVENTS_URL}/#{capital_call_event_id}#{query}")
		  end
  	  # Update an SPV capital call event
		  # @param
		  #   PATH PARAMETERS
		  #   - 'capital_call_event_id' [String] (required)
		  #   REQUEST BODY SCHEMA: application/json
		  #   - 'percentage' [Number] [ 0 .. 100 ]
		  #   - 'memo'       [String]
		  #
		  # Update an SPV capital call event. You can only update a capital call event before subscription captial calls
		  # have been made (e.g. if the capital call event has been created and the SPV has no subscriptions created yet).
		  #
		  # @EXAMPLE
		  #   Response samples:
		  #   {
		  #   "id": "string",
		  #   "created_at": "2019-08-24T14:15:22Z",
		  #   "updated_at": "2019-08-24T14:15:22Z",
		  #   "spv_id": "string",
		  #   "memo": "string",
		  #   "percentage": 0
		  #   }
		  # More detail see on the
		  # https://api-docs.sydecar.io/api/#tag/Capital-Call-Management/operation/updateCapitalCallEvent
		  # @return [Hash] see example
		  #   Response: > '200'
		  def update_SPV_capital_call(capital_call_event_id:, body: {})
		   Connection.instance.patch("#{CAPITAL_CALL_EVENTS_URL}/#{capital_call_event_id}", body)
		  end
  	  # Delete an SPV capital call event by id
		  # @param
		  #   PATH PARAMETERS
		  #   - 'capital_call_event_id' [String] (required)
		  #
		  # Delete an SPV capital call event. You can only delete a capital call event before subscription captial calls
		  # have been made (e.g. if the capital call event has been created but no subscriptions have been created for the SPV so far).
		  #
		  # @EXAMPLE
		  #   Response samples:
		  #   {
		  #   "id": "string",
		  #   "created_at": "2019-08-24T14:15:22Z",
		  #   "updated_at": "2019-08-24T14:15:22Z",
		  #   "spv_id": "string",
		  #   "memo": "string",
		  #   "percentage": 0
		  # }
		  # More detail see on the
		  # https://api-docs.sydecar.io/api/#tag/Capital-Call-Management/operation/removeCapitalCallEvent
		  # @return [Hash] see example
		  #   Response: > '200'
		  def delete_SPV_capital_call(capital_call_event_id:)
		   Connection.instance.delete("#{CAPITAL_CALL_EVENTS_URL}/#{capital_call_event_id}")
		  end
  	  # Get the capital call needed for a disbursement
		  # @param
		  #   QUERY PARAMETERS
		  #   - 'use_spv_allocation' [boolean] (optional)
		  #   REQUEST BODY SCHEMA: application/json
		  #   - 'spv_id' [String]            (required)
		  #   - 'disbursement' [Number >=0 ] (required)
		  #
		  # Returns the capital call percentage needed for sufficient funds for a given disbursement. Uses reserved
		  # subscription amounts, unless 'use_spv_allocation' is passed as 'true'.
		  #
		  # @EXAMPLE
		  #   Response samples:
		  #   {
		  #   "data": {
		  #     "capital_call_percentage": 0
		  #   }
		  # }
		  # More detail see on the
		  # https://api-docs.sydecar.io/api/#tag/Capital-Call-Management/operation/getCapitalCallNeededForDisbursement
		  # @return [Hash] see example
		  #   Response: > '200'
		  def get_capital_call_for_disbursement(body:, query: {})
		   query = "?#{URI.encode_www_form(query)}"
		   Connection.instance.post("#{CAPITAL_CALL_EVENTS_URL}/capital_call_needed_for_disbursement#{query}", body)
		  end
	  end
  end
end