# frozen_string_literal: true

require 'test_helper'

class AgreementControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get agreement_index_url
    assert_response :success
  end
end
