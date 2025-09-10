class MessagesController < ApplicationController
	before_action :set_conversation, only: [:index, :create]

	def index
		@messages = @conversation.messages.includes(:sender).order(:created_at)
		@recipient = @conversation.recipient
		@sender = @conversation.sender
		@message = @conversation.messages.build

		# Handle different request types
		if turbo_frame_request?
			# Turbo Frame navigation from left panel clicks
			render html: helpers.turbo_frame_tag("conversation_panel") { 
				render_to_string(partial: "conversations/conversation_right_panel") 
			}.html_safe
		else
			# Polling requests from JavaScript - just return the messages list
			render partial: "messages/messages", locals: { messages: @messages }
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
