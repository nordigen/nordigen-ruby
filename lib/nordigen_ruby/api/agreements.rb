# frozen_string_literal: true

module Nordigen
  class AgreementsApi
    ENDPOINT = "agreements/enduser/"
    attr_reader :client

    def initialize(client)
      # Nordigen client initialization
      @client = client
    end

    def create_agreement(institution_id:, max_historical_days: 90, access_valid_for_days: 90, access_scope: %w[
      balances
      details
      transactions
    ])
      # Create enduser agreement
      payload = {
        institution_id: institution_id,
        max_historical_days: max_historical_days,
        access_valid_for_days: access_valid_for_days,
        access_scope: access_scope,
      }
      client.request.post(ENDPOINT, payload).body
    end

    def get_agreements(limit: 100, offset: 0)
      # Get list of agreements
      params = { limit: limit, offset: offset }
      client.request.get(ENDPOINT, params).body
    end

    def get_agreement_by_id(agreement_id)
      # Get agreemenet by id
      client.request.get("#{ENDPOINT}#{agreement_id}/").body
    end

    def delete_agreement(agreement_id)
      # Delete agreement by id
      client.request.delete("#{ENDPOINT}#{agreement_id}/").body
    end

    def accept_agreement(agreement_id:, ip:, user_agent:)
      # Accept end user agreement
      client.request.put("#{ENDPOINT}#{agreement_id}/accept/").body
    end
  end
end
