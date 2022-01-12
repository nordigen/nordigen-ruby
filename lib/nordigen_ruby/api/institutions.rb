module Nordigen
    class InstitutionsApi

        ENDPOINT = "institutions"
        attr_reader :client

        def initialize(client)
            # Nordigen client initialization
            @client = client
        end

        def get_institutions(country)
            # Get list of institutions
            return client.request.get("#{ENDPOINT}/?country=#{country}").body
        end

        def get_institution_by_id(id)
            # Get single institution by id
            return client.request.get("#{ENDPOINT}/#{id}/").body
        end

    end
end
