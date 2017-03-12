class TweetsController < ApplicationController

	before_action :authenticate_user!

	def search
		search = REST::API::Search.new
		@tweets = search.user_timeline params[:q]
	end

end