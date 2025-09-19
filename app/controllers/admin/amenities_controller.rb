class Admin::AmenitiesController < ApplicationController
  before_action :set_world, only: [:index]
  # TODO: ADMIN controller for CRUD on amenities available for listings
  def index
    @amenities = @world.amenities.all
  end

  private

  def amenities_params
    params.require(:amenities).permit(:name, :description)
  end

  def set_world
    @world = World.find(params[:world_id])
  end
end
