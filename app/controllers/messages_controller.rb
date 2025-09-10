class MessagesController < ApplicationController
	before_action :set_conversation, only: [:index, :create]

	def index
		@messages = @conversation.messages.includes(:sender).order(:created_at)
		@recipient = @conversation.recipient
		@sender = @conversation.sender
		@message = @conversation.messages.build

		# Handle turbo frame request
		if turbo_frame_request?
			render partial: "conversations/conversation_panel"
		else
			# Polling requests from JavaScript - returns the messages list
			render partial: "messages/messages", locals: { messages: @messages }
		end
	end

	def create
		@message = @conversation.messages.new(message_params)
		@message.sender = current_user
		
		if @message.save
			redirect_to conversation_messages_path(@conversation)
		else
			@messages = @conversation.messages.includes(:sender).order(:created_at)
			@recipient = @conversation.recipient
			@sender = @conversation.sender
			render partial: "conversations/conversation_panel", status: :unprocessable_entity
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
