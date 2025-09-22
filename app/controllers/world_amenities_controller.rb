class WorldAmenitiesController < ApplicationController
	before_action :set_world, only: [:edit, :update, :destroy]
	before_action :set_world_amenity, only: [:destroy]

  def index
    @world_amenities = @world.amenities.all
  end

  def edit
    # edition on all available world amenities, not by ID
    @amenities = Amenity.all
  end

  def update
    # clean IDs submitted from checkboxes & convert ids to int
    selected_ids = params[:world_amenity][:id].reject(&:blank?).map(&:to_i)

    @world.amenity_ids = selected_ids

    if @world.update(amenity_ids: selected_ids)
      redirect_to world_path(@world), notice: "Amenities updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    raise
    if @world_amenity.destroy!
      redirect_to world_path(@world), notice: "Removed amenity"
    else
      redirect_to world_path(@world), alert: "Unable to remove amenity from this list"
    end
  end
  
  private
  
  def set_world
    @world = World.find(params[:world_id])
  end
  
  def set_world_amenity
    @world_amenity = @world.world_amenities.find(params[:id])
  end

  def world_amenity_params
    params.require(:world_amenity).permit(id: [])
  end
end