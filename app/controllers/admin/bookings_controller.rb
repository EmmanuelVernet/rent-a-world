class Admin::BookingsController < ApplicationController
	before_action :authenticate_user!
  # before_action :set_world
  # before_action :set_booking, only: [ :index, :show, :edit, :update, :accept, :decline ]

  def index
    if current_user.admin?
      @bookings = Booking.all
    else
      @bookings = current_user.bookings.order(created_at: :desc).all
    end
  end

  def new
    if current_user.admin?
      @booking = Booking.new
    else
      @booking = @world.bookings.new
    end
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

  private

  def booking_params
    params.require(:booking).permit(:user_id, :world_id, :status, :start_date, :end_date, :total_price)
  end

  # def set_booking
  #   @booking = Booking.find(params[:id])
  # end

  # def set_world
  #   @world = World.find(params[:world_id])
  # end
end
