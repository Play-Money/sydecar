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
  	  def fetch_capital_calls_for_SPV(params: {}, body: {})
  		  query = '?'
  		  query += URI.encode_www_form(params)
  		  Connection.instance.post("#{CAPITAL_CALL_EVENTS_URL}#{query}", body)
  	  end
	  end
  end
end