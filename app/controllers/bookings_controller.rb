class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_world, only: [:show, :new, :create]
  before_action :set_booking, only: [:show, :edit, :accept, :decline]

  # TODO: Create seperate namespaced controller for handling bookings like Admin::BookingsController, BookingsController handles both renter & rentee + adapt routes?

  def index
    # 1. Worlds owned with incoming booking requests
    @incoming_requests = Booking.joins(:world).where(worlds: { user_id: current_user.id }, status: "pending")
    # joins Model where (table name) => singular then plural

    # 2. Bookings requested as a guest
    @my_requests = current_user.bookings.includes(:world)

    # 3. All relevant bookings (as renter OR rentee)
    @all_requests = Booking.joins(:world).where("worlds.user_id = :id OR bookings.user_id = :id", id: current_user.id)

    # 4. Admin vs normal user: list all booking types
    @bookings = if current_user.admin?
      Booking.all.order(created_at: :desc)
    else
      current_user.bookings.order(created_at: :desc)
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
    @world = @booking.world
  end

  def edit
    @world = @booking.world
    @owner = @booking.world.user
  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: "Booking updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @booking.destroy
      redirect_to bookings_path, notice: "Booking destroyed!"
    else
      redirect_to booking_path(@booking), notice: "Booking can't be deleted!"
    end
  end

  def accept
    @booking.accept! # method in model
    redirect_to booking_path(@booking), notice: "Booking confirmed."
  end

  def decline
    @booking.decline!
    redirect_to bookings_path, notice: "Booking declined."
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :world_id, :status, :start_date, :end_date, :total_price)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_world
    @world = World.find(params[:world_id]) if params[:world_id]
  end
end
