class WorldsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_world, only: [ :show, :new, :edit, :create, :update, :destroy ]

  def index
    @worlds = World.all # TO DO: add later filtering for indexing all worlds for optimization to avoid N+1 queries
  end

  def new
    @world = World.new
  end

  def create
    @world = World.new(world_params) # TO DO: scope to current user
    if @world.save
      redirect_to world_path(@world), notice: "World was successfully created."
    else
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

  def world_params
    params.expect(:world).permit(:title, :category, :place, :price, :description, :capacity, :latitude, :longitude)
  end

  def set_world
    @world = World.find(params[:id])
  end
end
