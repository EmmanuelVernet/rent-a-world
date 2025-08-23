class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_world, only: [:show, :new, :create]
  before_action :set_booking, only: [:show]

  # TODO: Create seperate namespaced controller for handling bookings like Admin::BookingsController, BookingsController handles both renter & rentee + adapt routes?

  def index
    if current_user.admin?
      @bookings = Booking.all
    else
      @bookings = current_user.bookings.order(created_at: :desc).all
    end
  end

  def new
    @owner = @world.user
    # raise
    @booking = Booking.new
    @capacity = @world.capacity
    @world_price = @world.price
    # @booking_days = params[:end_date].to_date-params[:start_date].to_date
    # @total_price = @world.price * @capacity * @booking_days
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user # assign booking to current user
    @booking.world = @world
    @booking.status ||= "pending"

    # Calculate total price
    if @booking.start_date && @booking.end_date
      nights = (@booking.end_date - @booking.start_date).to_i
      @booking.total_price = nights * @world.price * @world.capacity
    end

    if @booking.save
      redirect_to world_booking_path(@world, @booking), notice: "Booking created!"
    else
      # make values available again for view
      @owner = @world.user
      @capacity = @world.capacity
      @world_price = @world.price
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def accept
  end

  def decline
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :world_id, :status, :start_date, :end_date, :total_price)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_world
    @world = World.find(params[:world_id])
  end
end
