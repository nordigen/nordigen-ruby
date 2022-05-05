module Nordigen
    class AccountApi

        ENDPOINT = "accounts/"
        attr_reader :client, :account_id

        def initialize(client:, account_id:)
            @client = client
            @account_id = account_id
        end

        def get(path = nil, params = nil)
            # Create Get request
            url = "#{ENDPOINT}#{@account_id}/"
            if path
                url = "#{url}#{path}/"
            end

            return client.request(params).get(url).body
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

        def get_transactions(date_from: nil, date_to: nil)
            # Access account transactions
            date_range = {
                "date_from" => date_from,
                "date_to"   => date_to
            }
            return get("transactions", date_range)
        end

    end
end
