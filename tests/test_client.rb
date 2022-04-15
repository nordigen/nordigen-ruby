require 'test/unit'
require 'dotenv/load'
require 'securerandom'

require_relative '../lib/nordigen-ruby'
require_relative '../lib/nordigen_ruby/api/institutions'

module Nordigen

    class TestClient < Test::Unit::TestCase

        def setup()
            @client = NordigenClient.new(secret_id: ENV["SECRET_ID"], secret_key: ENV["SECRET_KEY"])
        end

        def test_set_get_token
            # Test setter and getter for token
            new_token = "New token value"
            @client.set_token(new_token)
            token = @client.get_token()
            assert_equal(token, "Bearer #{new_token}")
        end

        def test_generate_token
            # Test generate new token
            response = @client.generate_token()
            assert_equal(response["access_expires"], 86400)
        end


        def test_exchange_token
            # Test exchange token
            refresh_token = @client.generate_token()["refresh"]
            response = @client.exchange_token(refresh_token)
            assert_equal(response["access_expires"], 86400)
        end

        def test_init_session
            # Test initialize session
            uuid = SecureRandom.uuid
            id = "REVOLUT_REVOGB21"
            response = @client.init_session(
                redirect_url: "https://nordigen.com", institution_id: id, reference_id: uuid
            )
            assert_equal(response["institution_id"], id)

        end

    end

end
