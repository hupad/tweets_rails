module REST
	module API
		class Search  
			include REST::Client

			def initialize
				@auth_token = get_token_from_twitter
			end

			def user_timeline screen_name, count=25
				
				url = "https://api.twitter.com/1.1/statuses/user_timeline.json?count=#{count}&screen_name=#{screen_name}"

				headers = {
					"Authorization" => "Bearer #{@auth_token}"
				}

				Rails.cache.fetch(url, expires_in: 5.minutes) do
					response = HTTParty.get(url, headers: headers)
					response.parsed_response
				end
			end
		end
	end
end