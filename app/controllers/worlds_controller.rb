class WorldsController < ApplicationController
  before_action :set_world, only: [ :show, :edit, :update, :destroy ]

  def index
    @worlds = World.all
  end

  def new
    @world = World.new
  end

  def create
    @world = World.new(world_params)
    if @world.save
      redirect_to world_path(@world), notice: "World was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @world = World.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def world_params
    params.require(:world).permit(:title, :category, :place, :price, :description, :capacity, :latitude, :longitude)
  end

  def set_world
    @world = World.find(params[:id])
  end
end
