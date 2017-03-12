require 'base64'

module REST
	module Client
		include HTTParty

		def get_token_from_twitter
			connect_to_twitter unless Rails.cache.read(:bearer_token)
			@access_token = Rails.cache.read(:bearer_token)
		end

		def connect_to_twitter

			credentials = encode_credentials Figaro.env.consumer_key, Figaro.env.consumer_secret
			
			body = set_body

			headers = set_headers credentials

			response = HTTParty.post("https://api.twitter.com/oauth2/token", body: body, headers: headers)

			authentication_token = return_access_token response
			
			Rails.cache.write(:bearer_token, authentication_token, expires_in: 24.hours)
		end

		def encode_credentials key, secret
			Base64.encode64("#{key}:#{secret}").gsub("\n", '')
		end

		def set_body
			"grant_type=client_credentials"
		end

		def set_headers credentials
			headers = {
				  "Authorization" => "Basic #{credentials}",
				  "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
			}

			headers
		end

		def return_access_token response
			response.parsed_response["access_token"] if (response.parsed_response["token_type"] == 'bearer')
		end
	end
end