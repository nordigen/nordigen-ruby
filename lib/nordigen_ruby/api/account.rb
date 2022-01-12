module Nordigen
    class AccountApi

        ENDPOINT = "accounts/"
        attr_reader :client, :account_id

        def initialize(client:, account_id:)
            @client = client
            @account_id = account_id
        end

        def get(path = nil)
            # Create Get request
            url = "#{ENDPOINT}#{@account_id}/"
            
            if path
                url = "#{url}#{path}/"
            end

            return client.request.get(url).body
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

        def get_transactions
            # Access account transactions
            return get("transactions")
        end

    end
end
