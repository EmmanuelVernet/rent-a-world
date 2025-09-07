class ReviewsController < ApplicationController
	before_action :set_world
	before_action :set_review, only: [:edit, :update, :destroy]

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
	end

	def update
		if @review.update(review_params)
			redirect_to world_path(@world)
		else
			render "world/show", status: :unprocessable_entity
		end
	end
	
	def destroy
		if @review.destroy!
			redirect_to world_path(@world), notice: "Review deleted!"
		else
			redirect_to world_path(@world), alert: "Impossible to delete!"
		end
	end

	private
	
	def review_params
		params.require(:review).permit(:world_id, :comment, :stars)
	end

	def set_world
		@world = World.find(params[:world_id])
	end

	def set_review
		@review = Review.find(params[:id])
	end
end
