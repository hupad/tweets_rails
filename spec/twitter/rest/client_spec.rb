require 'rails_helper'

describe 'Twitter Client' do

	let(:rest_client) { Class.new { include REST::Client }.new }

	it 'encodes client credentials' do

	credential = rest_client.encode_credentials Figaro.env.consumer_key, Figaro.env.consumer_secret

	expect(credential).not_to eql("")

	end

	it 'sets correct headers' do
		
		credentials = rest_client.encode_credentials Figaro.env.consumer_key, Figaro.env.consumer_secret

		expected_authorization = "Basic #{credentials}"
		expected_content_type = "application/x-www-form-urlencoded;charset=UTF-8"

		headers = rest_client.set_headers credentials

		expect(headers["Authorization"]).to eql(expected_authorization)
		expect(headers["Content-Type"]).to eql(expected_content_type)
	end

	it 'returns access token' do
		
		expected_token = "random_token"
		response = {"token_type" => "bearer", "access_token" => expected_token}

		access_token = rest_client.return_access_token response

		expect(access_token).to eql(expected_token)
	end

	it 'gets token from twitter' do
		
		expected_token = "random_token"

		stub_request(:post, "https://api.twitter.com/oauth2/token")
				.to_return({ body:  {token_type: "bearer", access_token: "random_token"}.to_json })
		
		rest_client.connect_to_twitter

		expect(Rails.cache.read(:bearer_token)).to eql(expected_token)
	end

end