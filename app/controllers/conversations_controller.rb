class ConversationsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_conversation, only: [:show]

	def index
		@conversations = Conversation.includes(:world, :sender, :recipient).where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id)).order(updated_at: :desc)
	end

	def show
		# Load conv messages for view
		@messages = @conversation.messages.includes(:sender).order(created_at: :asc)
		@recipient = @conversation.recipient
		@sender = @conversation.sender
		# instantiate a new message to render message form in show view
		@message = @conversation.messages.build
	end

	def create
		@conversation = Conversation.find_or_initialize_by(
    	sender_id: current_user.id,
    	recipient_id: conversation_params[:recipient_id],
    	world_id: conversation_params[:world_id]
  	)
		@conversation.sender = current_user

		if @conversation.save
			redirect_to conversations_path
		else
			# render :new, status: :unprocessable_entity
			redirect_to conversations_path, notice: "Could not create conversation."
		end
	end

	private

	def conversation_params
		params.require(:conversation).permit(:recipient_id, :world_id, :title)
	end

	def set_conversation
		@conversation = Conversation.find(params[:id])
	end
end
