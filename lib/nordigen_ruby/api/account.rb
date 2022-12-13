module Nordigen
    class AccountApi

        ENDPOINT = "accounts/"
        PREMIUM_ENDPOINT = "accounts/premium/"
        attr_reader :client, :account_id

        def initialize(client:, account_id:)
            @client = client
            @account_id = account_id
        end

        def get(path = nil, params = nil, premium = nil)
            # Create Get request
            if premium
                url = "#{PREMIUM_ENDPOINT}#{@account_id}/"
            else
                url = "#{ENDPOINT}#{@account_id}/"
            end

            if path
                url = "#{url}#{path}/"
            end

            return client.request.get(url, params).body
        end

        def get_metadata
            # Access account metadata
            return get()
        end

        def get_details
            # Access account details
            return get("details")
        end


        def get_balances
            #  Access account balances
            return get("balances")
        end

        def get_transactions(date_from: nil, date_to: nil, premium: nil)
            # Access account transactions
            date_range = {
                "date_from" => date_from,
                "date_to"   => date_to
            }
            return get("transactions", date_range, premium)
        end

    end
end
