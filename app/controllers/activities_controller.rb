class ActivitiesController < ApplicationController
	before_action :authenticate_user!, only: [:index]

	def index 
		@users = current_user.active_friends
		@users.push(current_user)
		@activities = PublicActivity::Activity.where(owner_id: @users).order('created_at DESC')
	end
	
end