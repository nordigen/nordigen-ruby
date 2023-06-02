# frozen_string_literal: true

require "test/unit"
require "dotenv/load"

require_relative "../lib/nordigen-ruby"
require_relative "../lib/nordigen_ruby/api/agreements"

module Nordigen
  class TestAgreements < Test::Unit::TestCase
    def setup
      client = NordigenClient.new(secret_id: ENV["SECRET_ID"],
                                  secret_key: ENV["SECRET_KEY"])
      client.generate_token
      @agreement = AgreementsApi.new(client)
      @institution_id = "REVOLUT_REVOGB21"
    end

    def test_create_agreement
      # Test create agreement
      response = @agreement.create_agreement(institution_id: @institution_id)
      assert_equal(response["institution_id"], @institution_id)
    end

    def test_get_agreement_by_id
      # Test Get agreement by id
      create_agreement = @agreement.create_agreement(institution_id: @institution_id)
      agreement_id = create_agreement["id"]
      response = @agreement.get_agreement_by_id(agreement_id)
      assert_equal(response["id"], agreement_id)
    end

    def test_get_agreements
      # Test Get list of agreements
      response = @agreement.get_agreements
      assert_equal(response["previous"], nil)
    end

    def test_delete_agreement
      # Test delete agreement
      create_agreement = @agreement.create_agreement(institution_id: @institution_id)
      agreement_id = create_agreement["id"]
      response = @agreement.delete_agreement(agreement_id)
      assert_equal(response["summary"], "End User Agreement deleted")
    end

    def test_accept_agreement
      # Test accept agreement
      omit("Available only for premium users")
      create_agreement = @agreement.create_agreement(institution_id: @institution_id)
      agreement_id = create_agreement["id"]
      response = @agreement.accept_agreement(
        user_agent: "Chrome",
        ip: "127.0.0.1",
        agreement_id: agreement_id,
      )
      assert_equal(response["id"], agreement_id)
    end
  end
end
