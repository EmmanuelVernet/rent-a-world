class WorldsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_world, only: [ :show, :edit, :update, :destroy ] # only allow for resources using params[:id]

  def index
    @worlds = World.all # TO DO: add later filtering for indexing all worlds for optimization to avoid N+1 queries
  end

  def new
    @world = World.new
  end

  def create
    # Rails.logger.info("Params: #{params.inspect}")  # Debugging
    @world = World.new(world_params) # TO DO: scope to current user
    if @world.save
      redirect_to world_path(@world), notice: "World was successfully created."
    else
      flash[:alert] = "Please correct the errors below."
      # Rails.logger.info("Flash alert: #{flash[:alert]}")    # Log the flash message
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # defined with set_world
    # instanciate activities & amenities since they have a many to many relationship
  end

  def edit
    # defined with set_world
  end

  def update
    if @world.update(world_params)
      redirect_to world_path(@world), notice: "World updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @world.destroy
      redirect_to worlds_path, notice: "World deleted!"
    else
      redirect_to worlds_path, alert: "Impossible to delete world"
    end
  end

  private

  def set_world
    @world = World.find(params[:id])
  end

  def world_params
    params.require(:world).permit(:title, :category, :place, :price, :description, :capacity, :latitude, :longitude)
  end
end
