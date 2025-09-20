class WorldAmenitiesController < ApplicationController
	before_action :set_world, only: [:index, :edit]
	before_action :set_world_amenity, only: [:edit]

  def index
    @world_amenities = @world.amenities.all
  end

  def edit
  end

  def update
    if @amenities.save!
      redirect_to world_path(@world)
    else
      render :edit, :unprocessable_entity
    end
  end

  private

  def set_world
    @world = World.find(params[:world_id])
  end

  def set_world_amenity
    # join table model
    @world_amenity = @world.world_amenities.find(params[:id])
  end

  def world_amenity_params
    params.require(:world_amenity).permit(:amenity_id)
  end
end