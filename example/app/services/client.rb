require 'nordigen-ruby'
require 'dotenv/load'

class Client

    def create_client
        # Create client instance
        return Nordigen::NordigenClient.new(
            secret_id: ENV["SECRET_ID"],
            secret_key: ENV["SECRET_KEY"]
        )
    end

end
