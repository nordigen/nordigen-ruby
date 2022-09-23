require 'test/unit'
require 'dotenv/load'

require_relative '../lib/nordigen_ruby/api/account'
require_relative '../lib/nordigen-ruby'

module Nordigen

    class TestAccount < Test::Unit::TestCase

        def setup()
            # Would it be possible to add a sandbox account
            # to the SANDBOXFINANCE_SFIN0000 institution,
            # that is always authorized?
            omit('Not yet possible to test in CI')

            client = NordigenClient.new(secret_id: ENV["SECRET_ID"], secret_key: ENV["SECRET_KEY"])
            client.generate_token()
            @account = AccountApi.new(client: client, account_id: ENV["ACCOUNT_ID"])
            @institution_id = "REVOLUT_REVOGB21"
        end

        def test_account_metadata
            # Test get account metadata
            response = @account.get_metadata()
            assert_equal(response["institution_id"], @institution_id)
        end


        def test_account_details
            # Test get account details
            response = @account.get_details()
            assert_equal(response["account"]["currency"], "EUR")
        end

        def test_account_balances
            # Test get account balances
            response = @account.get_balances()
            currency = response["balances"][0]["balanceAmount"]["currency"]
            assert_equal(currency, "EUR")
        end

        def test_account_transactions
            # Test get account transactions
            response = @account.get_transactions()
            assert_equal(response["booked"], nil)
        end

    end
end
