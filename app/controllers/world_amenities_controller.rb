class WorldAmenitiesController < ApplicationController
	before_action :set_world, only: [:index, :edit, :update]
	# before_action :set_world_amenity, only: [:edit]

  def index
    @world_amenities = @world.amenities.all
  end

  def edit
    @amenities = Amenity.all
  end

  def update
    # clean IDs submitted from checkboxes & convert to ids to int
    selected_ids = params[:world_amenity][:id].reject(&:blank?).map(&:to_i)

    @world.amenity_ids = selected_ids

    if @world.update(amenity_ids: selected_ids)
      redirect_to world_path(@world), notice: "Amenities updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_world
    @world = World.find(params[:world_id])
  end

  # def set_world_amenity
  #   # join table model
  #   @world_amenity = @world.world_amenities.find(params[:id])
  # end

  def world_amenity_params
    params.require(:world_amenity).permit(id: [])
  end
end