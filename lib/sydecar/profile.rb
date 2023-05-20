# frozen_string_literal: true
require 'sydecar/connection'

module Sydecar

  class Profile
    URL = '/v1/profiles/'.freeze
    ACCREDITATION_QUALIFICATION_URL = "#{URL}accreditation_qualification_options".freeze
    class << self
      def find(id:)
        url = "#{URL}#{id}"
        Connection.instance.get(url, { reveal_pii: true, include: 'subscriptions,spvs' })
      end

      # @param [Integer] id. Warning: this must be PROFILE_ID. Not SPV ID
      def activate_spv_url(id:)
        "/v1/profiles/#{id}/activate"
      end

      # TODO: check with Sydecar why this is called "activate SPV" whereas a PROFILE_ID is passed
      # @param [Integer] id. Warning: this must be PROFILE_ID. Not SPV ID
      def activate_spv(id:)
        Connection.instance.post(activate_spv_url(id: id))
      end

      # @param [Integer] id. Warning: this must be PROFILE_ID. Not SPV ID
      def deactivate_spv_url(id:)
        "/v1/profiles/#{id}/deactivate"
      end

      # TODO: check with Sydecar why this is called "deactivate SPV" whereas a PROFILE_ID is passed
      # @param [Integer] id. Warning: this must be PROFILE_ID. Not SPV ID
      def deactivate_spv(id:)
        Connection.instance.post(deactivate_spv_url(id: id))
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

      # @param [String] sub_type. Enum: "ENTITY", "PERSON"
      # @param [String] entity_type. Enum: "SOLE_PROPRIETOR"
      # "SINGLE_MEMBER_LLC"
      # "LLC"
      # "PARTNERSHIP"
      # "C_CORPORATION"
      # "S_CORPORATION"
      # "TRUST"
      # "IRA_OR_TAX_EXEMPT"
      # "NON_US_CORPORATION"
      # "PRIVATE_LIMITED_COMPANY"
      # "PUBLIC_LIMITED_COMPANY"
      # "TAX_EXEMPT_ENTITY"
      # "FOREIGN_TRUST"
      # "OTHER"
      def accreditation_qualification_opts(sub_type: , entity_type:)
        body = { sub_type: sub_type, entity_type: entity_type }
        Connection.instance.post(ACCREDITATION_QUALIFICATION_URL, body)
      end
    end
  end
end