module Nordigen
    class RequisitionsApi

        ENDPOINT = "requisitions/"
        attr_reader :client

        def initialize(client)
            # Nordigen client initialization
            @client = client
        end

        def create_requisition(redirect_url:, reference:, institution_id:, user_language: "en", agreement: nil, account_selection: false, redirect_immediate: false)
            # Create requisition. For creating links and retrieving accounts.
            payload = {
                "redirect": redirect_url,
                "reference": reference,
                "institution_id": institution_id,
                "user_language": user_language,
                "account_selection": account_selection,
                "redirect_immediate" redirect_immediate
            }

            if agreement
                payload["agreement"] = agreement
            end
                        
            return client.request.post(ENDPOINT, payload).body
        end

        def get_requisitions(limit: 100, offset: 0)
            # Get all requisitions
            params = {limit: limit, offset: offset}
            return client.request.get(ENDPOINT, params).body
        end


        def get_requisition_by_id(requisition_id)
            # Get requisition by id
            return client.request.get("#{ENDPOINT}#{requisition_id}/").body
        end

        def delete_requisition(requisition_id)
            # Delete requisition by id 
            return client.request.delete("#{ENDPOINT}#{requisition_id}/").body
        end

    end
end
