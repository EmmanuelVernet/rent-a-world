class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_world
  # before_action :set_booking, only: [ :index, :show, :edit, :update, :accept, :decline ]

  # TODO: Create seperate namespaced controller for handling bookings like Admin::BookingsController, BookingsController handles both renter & rentee + adapt routes?

  def index
    if current_user.admin?
      @bookings = Booking.all
    else
      @bookings = current_user.bookings.order(created_at: :desc).all
    end
  end

  def new
    # if current_user.admin?
    #   @booking = Booking.new
    # else
    #   @booking = @world.bookings.new
    # end
    @world.user = current_user
    @booking = Booking.new
    @capacity = @world.capacity
    @world_price = @world.price
    # @booking_days = params[:end_date].to_date-params[:start_date].to_date
    # raise
    # @total_price = @world.price * @capacity * @booking_days
  end

  def create
    @booking.user = current_user
    if @booking.save
      redirect_to world_booking_path(@booking)
    else
      redirect_to booking_path(@booking), status: :unprocessable_entity
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

  # def set_booking
  #   @booking = Booking.find(params[:id])
  # end

  def set_world
    @world = World.find(params[:world_id])
  end
end
