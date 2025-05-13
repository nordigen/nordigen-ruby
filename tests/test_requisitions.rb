# frozen_string_literal: true

require 'test/unit'
require 'dotenv/load'
require 'securerandom'

require_relative '../lib/nordigen-ruby'
require_relative '../lib/nordigen_ruby/api/requisitions'

module Nordigen
  class TestRequisitions < Test::Unit::TestCase
    def setup
      client = NordigenClient.new(secret_id: ENV['SECRET_ID'], secret_key: ENV['SECRET_KEY'])
      client.generate_token
      @requisition = RequisitionsApi.new(client)

      @institution_id = 'REVOLUT_REVOGB21'
      @req_params = {
        redirect_url: 'https://bankaccountdata.gocardless.com',
        reference: SecureRandom.uuid,
        institution_id: @institution_id
      }
    end

    def test_create_requisition
      # Test create requisition
      SecureRandom.uuid
      response = @requisition.create_requisition(**@req_params)
      assert_equal(response['institution_id'], @institution_id)
    end

    def test_get_requisitions
      # Test get list of requisitions
      response = @requisition.get_requisitions
      assert_equal(response['previous'], nil)
    end

    def test_get_requisition_by_id
      # Test get requisition by id
      new_requisition = @requisition.create_requisition(**@req_params)
      id = new_requisition['id']
      response = @requisition.get_requisition_by_id(id)
      assert_equal(response['id'], id)
    end

    def test_delete_requisition
      # Test delete requisition
      new_requisition = @requisition.create_requisition(**@req_params)
      id = new_requisition['id']
      response = @requisition.delete_requisition(id)
      assert_equal(response['summary'], 'Requisition deleted')
    end
  end
end
