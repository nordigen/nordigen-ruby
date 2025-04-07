# Nordigen Ruby Library

### ⚠️ Notice
Please be advised that the Bank Account Data libraries are no longer actively updated or maintained. While these libraries may still function, GoCardless will not provide further updates, bug fixes, or support for them.
#

This is official Ruby client library for [GoCardless Bank Account Data](https://gocardless.com/bank-account-data/).

For a full list of endpoints and arguments, see the [docs](https://developer.gocardless.com/bank-account-data/quick-start-guide).

Before starting to use API you will need to create a new secret and get your `SECRET_ID` and `SECRET_KEY` from the [GoCardless Bank Account Data Portal](https://bankaccountdata.gocardless.com/user-secrets/).

## Requirements

* Ruby 2.6+


## Installation


Install library

```
gem install nordigen-ruby
```

## Example application

Example code can be found in `main.rb` file and Ruby on Rails example application can be found in `example` directory

## Quickstart


```ruby
require 'securerandom'
require 'nordigen-ruby'

# Get secret_id and secret_key from bankaccountdata.gocardless.com/user-secrets/ portal and pass to NordigenClient or load from .env file
client = Nordigen::NordigenClient.new(
  secret_id: "SECRET_ID",
  secret_key: "SECRET_KEY"
)

# Generate new access token. Token is valid for 24 hours
token_data = client.generate_token()

# Use existing token
client.set_token("YOUR_TOKEN")

# Get access and refresh token
# Note: access_token is automatically injected to other requests after you successfully obtain it
access_token = token_data["access"]
refresh_token = token_data["refresh"]

# Exchange refresh token. Refresh token is valid for 30 days
refresh_token = client.exchange_token(refresh_token)

# Get all institution by providing country code in ISO 3166 format
institutions = client.institution.get_institutions("LV")

# Institution id can be gathered from get_institutions response.
# Example Revolut ID
id = "REVOLUT_REVOGB21"

# Initialize bank authorization session
# Returns requisition_id and link to initiate authorization with a bank
init = client.init_session(
  # redirect url after successful authentication
  redirect_url: "https://gocardless.com",
  # institution id
  institution_id: id,
  # a unique user ID of someone who's using your services, usually it's a UUID
  reference_id: SecureRandom.uuid,
  # A two-letter country code (ISO 639-1)
  user_language: "en",
  # option to enable account selection view for the end user
  account_selection: true
)

link = init["link"] # bank authorization link
requisition_id = init["id"] # requisition id that is needed to get an account_id
puts link
```

After successful authorization with a bank you can fetch your data (details, balances, transactions)


## Fetching account metadata, balances, details and transactions

```ruby

# Get account id after you have completed authorization with a bank.
requisition_data = client.requisition.get_requisition_by_id(requisition_id)
# Get account id from list
account_id =  requisition_data["accounts"][0]

# Instantiate account object
account = client.account(account_id)

# Fetch account metadata
meta_data = account.get_metadata()
# Fetch details
details = account.get_details()
# Fetch balances
balances = account.get_balances()
# Fetch transactions
transactions = account.get_transactions()
# Fetch premium transactions
transactions = account.get_premium_transactions(date_from: "2021-12-01", date_to: "2022-01-30", country: "LV")
# Filter transactions by specific date range
transactions = account.get_transactions(date_from: "2021-12-01", date_to: "2022-01-30")
```

## Development

Run all tests in a directory
```bash
bundle exec rake test
```

## Support

For any inquiries please contact support at [bank-account-data-support@gocardless.com](bank-account-data-support@gocardless.com) or create an issue in repository.
