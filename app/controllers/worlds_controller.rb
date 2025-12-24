class WorldsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_world, only: [ :show, :edit, :update, :destroy ]

  def index
    @tags = Tag

    # World pg_search querying
    if params[:query].present?
      # search_by_fields method in World model
      @worlds = World.search_by_fields(params[:query])
    else
      @worlds = World.includes(:user, :tags)
    end
  end

  def my_worlds
    @worlds = current_user.worlds.includes(:tags)
    @tags = Tag.all
  end

  def new
    @world = World.new
  end

  def create
    # Rails.logger.info("Params: #{params.inspect}")  # Debugging
    @world = World.new(world_params)
    @world.user = current_user

    if @world.save
      redirect_to world_path(@world), notice: "World was successfully created."
    else
      flash[:alert] = "Please correct the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # defined with set_world
    @activities = @world.activities
    @amenities = @world.amenities
    # init review for review form load
    @review = Review.new(world: @world) 
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
      redirect_to my_worlds_worlds_path, notice: "World deleted!"
    else
      redirect_to my_worlds_worlds_path, alert: "Impossible to delete world"
    end
  end

  private
  
  def world_params
    params.require(:world).permit(:title, :category, :place, :price, :description, :capacity, :latitude, :longitude, activity_ids: [], amenity_ids: [], tag_ids: [])
  end

  def set_world
    @world = World.includes(reviews: :user, activities: []).find(params[:id])
    # preload join table amenities association
    @world_amenities = @world.world_amenities.includes(:amenity)
    @world_activities = @world.world_activities.includes(:activity)
  end
end
