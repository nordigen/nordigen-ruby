require_relative "../services/client"

require "nordigen_ruby/api/institutions"

class HomeController < ApplicationController
    def index
        country = "DE"
        client = Client.new().create_client()
        token = client.generate_token()["access"]
        institution = Nordigen::InstitutionsApi.new(client=client)
        institution_list = institution.get_institutions(country)
        institution_list.map { |i| i["name"] }


        @list = institution_list.collect {|el| OpenStruct.new(el).marshal_dump }.to_json

    end
end
