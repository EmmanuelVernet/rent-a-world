class WorldActivitiesController < ApplicationController
	before_action :set_world, only: [:edit]
	before_action :set_world_activity, only: [:destroy]

	def edit
		@activities = Activities.all
	end

	private

	def set_world
		@world = World.find(params[:world_id])
	end
	
	def set_world_activity
		@world_activity = @world.activities.find(params[:id])
	end

	def world_activity_params
		params.require(:world_activity).permit(id: [])
	end
end
