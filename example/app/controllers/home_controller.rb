# frozen_string_literal: true

require_relative '../services/client'

require 'nordigen_ruby/api/institutions'

class HomeController < ApplicationController
  def index
    client = Client.new.create_client
    client.generate_token['access']

    # Get all institutions in specific country
    country = 'LV'
    institution = Nordigen::InstitutionsApi.new(client)
    institution_list = institution.get_institutions(country)
    @list = institution_list.collect { |el| OpenStruct.new(el).marshal_dump }.to_json
  end
end
