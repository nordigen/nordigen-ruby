require 'json'

class ResultsController < ApplicationController
    def index
        client = Client.new().create_client()
        requisition_id = session[:requisition_id]

        if !requisition_id
            raise "Requisition ID is not found. Please complete authorization with your bank"
        end

        requisition_data = client.requisition.get_requisition_by_id(requisition_id)
        account_id = requisition_data["accounts"][0]

        account = client.account(account_id)
        account_data = [{
            "metadata": account.get_metadata(),
            "balances": account.get_balances(),
            "details": account.get_details(),
            "transactions": account.get_transactions()
        }]

        render :json => JSON.pretty_generate(JSON.parse(account_data.to_json))

    end
end
