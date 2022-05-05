require 'test/unit'
require 'dotenv/load'

require_relative '../lib/nordigen-ruby'
require_relative '../lib/nordigen_ruby/api/institutions'

module Nordigen

    class TestInstitutions < Test::Unit::TestCase

        def setup()
            client = NordigenClient.new(secret_id: ENV["SECRET_ID"], secret_key: ENV["SECRET_KEY"])
            client.generate_token()
            @institution = InstitutionsApi.new(client=client)
            @institution_id = "REVOLUT_REVOGB21"
        end

        def test_get_institutions
            # Test get list of institutions
            institutions = @institution.get_institutions("LV")
            id = institutions.each{ |k,v| return k["id"] if k["id"] == @institution_id}
            assert_equal(id, @institution_id)
        end

        def test_get_institution_by_id
            # Test get institution by id
            institutions = @institution.get_institution_by_id(id=@institution_id)
            assert_equal(institutions["id"], @institution_id)
        end

    end

end
