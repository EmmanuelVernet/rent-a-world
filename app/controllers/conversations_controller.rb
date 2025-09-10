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

# create_table "conversations", force: :cascade do |t|
#     t.bigint "world_id", null: false
#     t.bigint "sender_id", null: false
#     t.bigint "recipient_id", null: false
#     t.string "title"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
#     t.index ["sender_id", "recipient_id", "world_id"], name: "index_conversations_on_sender_id_and_recipient_id_and_world_id", unique: true
#     t.index ["sender_id"], name: "index_conversations_on_sender_id"
#     t.index ["world_id"], name: "index_conversations_on_world_id"
#   end