require 'securerandom'
require_relative "../services/client"

class AgreementsController < ApplicationController
  def index
    id = params[:id]

    if id == nil
      redirect_to '/'
    end

    client = Client.new().create_client()
    uuid = SecureRandom.uuid
    redirect_url = "http://localhost:3000/results/"
    init = client.init_session(redirect_url: redirect_url, institution_id: id, reference_id: uuid)
    puts init
    session[:requisition_id] = init.id
    redirect_to init.link

  end
end
