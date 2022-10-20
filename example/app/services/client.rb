require 'nordigen-ruby'
require 'dotenv/load'

class Client

    def create_client
        # Create client instance
        return Nordigen::NordigenClient.new(
            secret_id: "83ab553b-bff9-4232-8b71-8d27a7adc1f2",
            secret_key: "e6328427a3aac3f6bf4f2f74fa0125c65f5937979cda889a43da2cb6ec197483b5ad7fd165a4ef994072857bd02fd36284efbf97371b9e9019460cbcfbd09025"
        )
    end

end
