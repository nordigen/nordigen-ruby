# frozen_string_literal: true

require "test/unit"
require "dotenv/load"

require_relative "../lib/nordigen-ruby"
require_relative "../lib/nordigen_ruby/api/institutions"

module Nordigen
  class TestInstitutions < Test::Unit::TestCase
    def setup
      client = NordigenClient.new(secret_id: ENV["SECRET_ID"],
                                  secret_key: ENV["SECRET_KEY"])
      client.generate_token
      @institution = InstitutionsApi.new(client)
      @institution_id = "REVOLUT_REVOGB21"
    end

    def test_get_institutions
      # Test get list of institutions
      institutions = @institution.get_institutions("LV")
      id = institutions.collect { |k, _v| k["id"] }
      assert_includes(id, @institution_id)
    end

    def test_get_institution_by_id
      # Test get institution by id
      institutions = @institution.get_institution_by_id(@institution_id)
      assert_equal(institutions["id"], @institution_id)
    end
  end
end
