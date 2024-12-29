class WorldsController < ApplicationController
  def index
    @worlds = World.all
  end

  def new
  end

  def create
  end

  def show
    @world = World.find(params[:id])
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def world_params
    params.require(:world).permit(:title, :category, :place, :price, :description, :capacity, :latitude, :longitude)
  end
end
