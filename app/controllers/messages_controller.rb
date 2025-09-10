class MessagesController < ApplicationController
	before_action :set_conversation, only: [:index, :create]

	def index
		@messages = @conversation.messages.includes(:sender).order(:created_at)

  	# render partial: "messages/messages", locals: { messages: @messages }

		respond_to do |format|
    	format.html  # for the full page
    	format.turbo_stream { render partial: "conversations/conversation_right_panel", locals: { conversation: @conversation, messages: @messages, message: @message } }
  	end
	end

	def create
		@message = @conversation.messages.new(message_params)
		@message.sender = current_user
		
		if @message.save
			redirect_to conversation_path(@conversation)
		else
			render "conversations/show", status: :unprocessable_entity
		end
	end

	private

	def message_params
		params.require(:message).permit(:body)
	end

	def set_conversation
		@conversation = Conversation.find(params[:conversation_id])
	end
end
