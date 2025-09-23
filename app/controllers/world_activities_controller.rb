class WorldActivitiesController < ApplicationController
	before_action :set_world, only: [:edit, :update]
	# before_action :set_world_activity, only: [:destroy]

	def edit
		@activities = Activity.all
	end

	def update
		# clean IDs submitted from checkboxes & convert ids to int
    selected_ids = params[:world_activity][:id].reject(&:blank?).map(&:to_i)

		# reassign activity ids with new IDs
    @world.activity_ids = selected_ids

    if @world.update(activity_ids: selected_ids)
      redirect_to world_path(@world), notice: "Amenities updated."
    else
      render :edit, status: :unprocessable_entity
    end
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
