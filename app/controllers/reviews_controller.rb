class ReviewsController < ApplicationController
	before_action :set_world
	before_action :set_review, only: [:edit, :update]

	# def index
	# 	@reviews = @world.reviews.order(:created_at)
	# end

	def create
		@review = @world.reviews.new(review_params)
		@review.user = current_user
		
		if @review.save!
			respond_to do |format|
				format.turbo_stream
				format.html { redirect_to @world}
			end
		else
			render "world/show", status: :unprocessable_entity
		end
	end

	def edit
		respond_to do |format|
			format.turbo_stream
			format.html
		end
	end

	def update
		if @review.update(review_params)
			respond_to do |format|
				format.turbo_stream
				format.html { redirect_to @world}
			end
		else
			render "world/show", status: :unprocessable_entity
		end
	end
	

	private
	
	def review_params
		params.require(:review).permit(:user_id, :world_id, :comment, :stars) # check if allowing user_id param is security breach
	end

	def set_world
		@world = World.find(params[:world_id])
	end

	def set_review
		@review = Review.find(params[:id])
	end
end
