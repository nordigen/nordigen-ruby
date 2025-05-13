# frozen_string_literal: true

module Nordigen
  class AccountApi
    ENDPOINT = "accounts/"
    PREMIUM_ENDPOINT = "accounts/premium/"
    attr_reader :client, :account_id

    def initialize(client:, account_id:)
      @client = client
      @account_id = account_id
    end

    def get(path = nil, params = nil, premium: nil)
      # Create Get request
      url = if premium
              "#{PREMIUM_ENDPOINT}#{@account_id}/"
      else
              "#{ENDPOINT}#{@account_id}/"
      end

      url = "#{url}#{path}/" if path

      client.request.get(url, params).body
    end

    def get_metadata
      # Access account metadata
      get
    end

    def get_details
      # Access account details
      get("details")
    end

    def get_balances
      #  Access account balances
      get("balances")
    end

    def get_transactions(date_from: nil, date_to: nil)
      # Access account transactions
      date_range = {
        "date_from" => date_from,
        "date_to" => date_to
      }
      get("transactions", date_range)
    end

    def get_premium_transactions(date_from: nil, date_to: nil, country: nil)
      # Access account transactions
      params = {
        "date_from" => date_from,
        "date_to" => date_to,
        "country" => country
      }
      get("transactions", params, premium: true)
    end
  end
end
