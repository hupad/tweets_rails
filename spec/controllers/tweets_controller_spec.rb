require 'rails_helper'

describe TweetsController do
	describe 'GET search' do
		it 'renders tweets for a given screen name' do
			get :search, params: {q: "harishgeeth"}

			expect(response).to have_selector('p', count: 1)
		end
	end
end