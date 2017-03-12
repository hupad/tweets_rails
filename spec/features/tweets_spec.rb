require 'rails_helper'


feature 'tweets page' do
	scenario 'user searches by a screen name' do

		visit "/"

		fill_in("q", with: "harishgeeth")

		click_on("Search")

		expect(page).to have_selector("p", minimum: 25)
	end
end