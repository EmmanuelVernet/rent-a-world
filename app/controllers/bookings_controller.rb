class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_world, only: [:show, :new, :edit, :create]
  before_action :set_booking, only: [:show, :edit, :update, :accept, :cancel]

  # TODO: Create seperate namespaced controller for handling bookings like Admin::BookingsController

  def index
    # 1. Worlds owned with incoming booking requests
    @incoming_requests = Booking.joins(:world).where(worlds: { user_id: current_user.id }, status: "pending").includes(:user, world: :user)
    # joins Model where (table name) => singular then plural

    # 2. Bookings requested as a guest
    @my_requests = current_user.bookings

    # 3. All relevant bookings (as renter OR rentee)
    @all_requests = Booking.joins(:world).where("worlds.user_id = :id OR bookings.user_id = :id", id: current_user.id).includes(:user, world: :user)

    # 4. Admin vs normal user: list all booking types
    @bookings = if current_user.admin?
      Booking.all.order(created_at: :desc)
    else
      current_user.bookings.order(created_at: :desc)
    end

    respond_to do |format|
      format.html
      format.json do
        # All calendar events response
        render json: @all_requests.map { |b|
          {
            id: b.id,
            calendarId: "bookings",
            title: b.world.title,
            status: b.status,
            start: b.start_date.iso8601,
            end: b.end_date.iso8601,
          }
        }
      end
    end
  end

  def new
    @owner = @world.user
    @booking = Booking.new
    @capacity = @world.capacity
    @world_price = @world.price
    @unavailabilities =  @world.unavailable_dates if @world.bookings.any?
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user # assign booking to current user
    @booking.world = @world
    @booking.status ||= "pending"
    # /!\ Total price calculated in model

    if @booking.save
      # Notify world owner before redirect. Recipient defined in notifier
      NewBookingRequestNotifier.with(record: @booking).deliver
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
    if @booking.user == current_user
      @world = @booking.world
      @owner = @booking.world.user
      @capacity = @world.capacity
      @world_price = @world.price
    else
      redirect_to booking_path(@booking), notice: "Only the guest can edit the booking request"
    end
  end
  
  def update
    @booking.status = "pending" # edition re-sets booking as pending
    if @booking.update(booking_params)
      # new total price calculated in model
      redirect_to booking_path(@booking), notice: "Booking updated!"
    else
      flash.now[:alert] = "Your booking couldn't be updated"
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
    # Notify booking requester before redirect. Recipient defined in notifier
    BookingStatusNotifier.with(record: @booking).deliver
    redirect_to booking_path(@booking), notice: "Booking confirmed."
  end

  def cancel
    @booking.cancel!
    # Notify booking requester before redirect. Recipient defined in notifier
    BookingStatusNotifier.with(record: @booking).deliver
    redirect_to bookings_path, notice: "Booking cancelled."
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :world_id, :status, :start_date, :end_date, :total_price)
  end

  def set_booking
    @booking = Booking.includes(:user).find(params[:id])
  end

  def set_world
    @world = World.find(params[:world_id]) if params[:world_id]
  end
end
