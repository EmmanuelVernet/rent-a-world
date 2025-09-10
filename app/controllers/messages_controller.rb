class MessagesController < ApplicationController
	before_action :set_conversation

	def create
		@message = @conversation.messages.new
		@message.sender = current_user
		
		if @message.save
			redirect_to conversation_path(@conversation)
		else
			render "conversation/show", status: :unprocessable_entity
		end
	end

	private

	def message_params
		params.require(:message).permit(:body)
	end

	def set_conversation
		@conversation = Conversation.find(params[conversation_id])
	end
end
