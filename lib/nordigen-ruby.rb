require "faraday"

require_relative "nordigen_ruby/api/institutions"
require_relative "nordigen_ruby/api/agreements"
require_relative "nordigen_ruby/api/requisitions"
require_relative "nordigen_ruby/api/account"

module Nordigen
    class NordigenClient

        BASE_URL = "https://ob.nordigen.com/api/v2/"

        @@headers = {
            "accept" => "application/json",
            "Content-Type" => "application/json",
            "User-Agent" => "Nordigen-Ruby-v2"
        }

        attr_reader :secret_id, :secret_key, :institution, :agreement, :requisition

        def initialize(secret_id:, secret_key:)
            @secret_id = secret_id
            @secret_key = secret_key
            @institution = InstitutionsApi.new(client=self)
            @agreement = AgreementsApi.new(client=self)
            @requisition = RequisitionsApi.new(client=self)
        end

        def request
            # HTTP client request
            @request ||= Faraday.new do |conn|
                conn.url_prefix = BASE_URL
                conn.headers = @@headers
                conn.request :json
                conn.response :json
            end
        end

        def set_token(access_token)
            # Use existing token
            @@headers["Authorization"] = "Bearer #{access_token}"
        end

        def get_token
            # Get token
            return request.headers["Authorization"]
        end

        def generate_token
            # Generate new access & refresh token
            payload = {
                "secret_key": @secret_key,
                "secret_id": @secret_id
            }
            response = self.request.post("token/new/", payload)
            if !response.success?
                raise Exception.new response.body
            end

            @@headers["Authorization"] = "Bearer #{response.body['access']}"
            request.headers = @@headers
            return response.body
        end

        def exchange_token(refresh_token)
            # Exchange refresh token for access token
            payload = {"refresh": refresh_token}
            response = self.request.post("token/refresh/", payload).body
            @@headers["Authorization"] = "Bearer #{response['access']}"
            request.headers = @@headers
            return response
        end


        def account(account_id)
            # Create Account instance
            return AccountApi.new(client: self, account_id: account_id)
        end

        def init_session(
            redirect_url:,
            institution_id:,
            reference_id:,
            max_historical_days: 90,
            access_valid_for_days: 90,
            user_language: "en",
            account_selection: false,
            redirect_immediate: false,
            ssn: nil
        )
            # Factory method that creates authorization in a specific institution
            # and are responsible for the following steps:
            #   * Creates agreement
            #   * Creates requisiton

            # Create agreement
            new_agreement = @agreement.create_agreement(
                institution_id: institution_id,
                max_historical_days: max_historical_days,
                access_valid_for_days: access_valid_for_days
            )

            # Create requisition
            new_requsition = @requisition.create_requisition(
                redirect_url: redirect_url,
                reference: reference_id,
                institution_id: institution_id,
                user_language: user_language,
                account_selection: account_selection,
                redirect_immediate: redirect_immediate,
                agreement: new_agreement["id"],
                ssn: ssn
            )

            return new_requsition
        end

    end
end
