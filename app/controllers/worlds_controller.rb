class WorldsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_world, only: [ :show, :edit, :update, :destroy ] # only allow for resources using params[:id]

  def index
    @tags = Tag.all

    # World pg_search querying
    if params[:query].present?
      # search_by_fields method in World model
      @worlds = World.search_by_fields(params[:query])
    else
      @worlds = World.all # TO DO: add later filtering for indexing all worlds for optimization to avoid N+1 queries
    end
  end

  def my_worlds
    @worlds = current_user.worlds
    @tags = Tag.all
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
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # defined with set_world
    # instanciate activities & amenities since they have a many to many relationship
    # @world = World.includes(:activities).find(params[:id])  # Eager loading activities
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
    params.require(:world).permit(:title, :category, :place, :price, :description, :capacity, :latitude, :longitude)
  end

  def set_world
    @world = World.find(params[:id])
  end
end
