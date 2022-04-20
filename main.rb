# frozen_string_literal: true
require 'securerandom'
require_relative "lib/nordigen-ruby"

module Nordigen
    # Load token from .env file or replace with a string value
    # Secrets can be generated from ob.nordigen.com portal
    client = Nordigen::NordigenClient.new(
        secret_id: "SECRET_ID",
        secret_key: "SECRET_KEY"
    )

    # Generate token
    token_data = client.generate_token()
    refresh_token = token_data["refresh"]

    # Exchange token
    # new_token = client.exchange_token(access_token)

    # Use existing token
    # client.set_token("YOUR_TOKEN")

    # Get all institution by providing country code in ISO 3166 format
    institutions = client.institution.get_institutions("LV")

    # Institution id can be gathered from get_institutions response. Example Revolut id
    id = "REVOLUT_REVOGB21"

    # Initialize bank authorization session
    init = client.init_session(
        redirect_url: "https://nordigen.com",
        institution_id: id,
        reference_id: SecureRandom.uuid
    )
    requisition_id = init["id"]
    puts init["link"]

    # Get account id after you have completed authorization with a bank
    accounts = client.requisition.get_requisition_by_id(requisition_id)

    begin
        # Get account id from list
        account_id =  accounts["accounts"][0]
    rescue
        puts "Account list is empty. Make sure you have completed authorization with a bank."
    end

    # # Get account data
    account = client.account(account_id)

    meta = account.get_metadata()
    details = account.get_details()
    balances = account.get_balances()
    transactions = account.get_transactions()

end
