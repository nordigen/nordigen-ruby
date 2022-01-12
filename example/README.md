# Nordigen-Ruby example app with Ruby on Rails

## Set-up
---
You'll need to get your `SECRET_ID` and `SECRET_KEY` from the [Nordigen's Open Banking Portal](https://ob.nordigen.com/).
In **app.py** file provide the token as a parameter for `NordigenClient`.

```ruby
# Init Nordigen client
# In services/ directory you can modify secret_id & secret_key or store the values in .env file
client = Nordigen::NordigenClient.new(
    secret_id: ENV["SECRET_ID"],
    secret_key: ENV["SECRET_KEY"]
)
```

To initialize session with a bank, you have to specify `country` (a two-letter country code) and your `redirect_uri`.
In `controllers/home_controller.rb` directory, modify `country` value.
```ruby
country = 'LV'
```

In `agreements.controller.rb` modify your `redirect_uri` value.
```ruby
redirect_url = "http://localhost:3000/results/"
```

## Installation
---
Install dependencies

```bash
bundle install
```

Start Rails app

```bash
rails s
```

Below is an example of the authentication process with Revolut.

### 1. Go to http://localhost:3000/ and select bank
<p align="center">
    <img align="center" src="./resources/_media/f_3_select_aspsp.png" width="200" />
</p>

### 2. Provide consent
<p align="center">
  <img src="./resources/_media/f_4_ng_agreement.jpg" width="200" />
  <img src="./resources/_media/f_4.1_ng_redirect.png" width="200" />
</p>

### 3. Sign into bank (Institution)
<p align="center">
  <img src="./resources/_media/f_5_aspsps_signin.png" width="230" />
  <img src="./resources/_media/f_5.1_aspsps_signin.jpg" width="200" />
  <img src="./resources/_media/f_5.2_aspsps_signin.jpg" width="200" />
</p>

<p align="center">
  <img src="./resources/_media/f_5.3_aspsp_auth.jpg" width="200" />
</p>

### 4. Select accounts
<p align="center">
  <img src="./resources/_media/f_6_aspsp_accs.jpg" width="200" />
</p>

### 5. You will be redirected to specified `redirect_uri` in our case it is `http://localhost:5000/` where details, balances and transactions will be returned from your bank account.
