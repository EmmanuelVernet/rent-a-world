class ConversationsController < ApplicationController

	def index
		@conversations = Conversation.includes(:world, :sender, :recipient).where(sender_id: current_user.id).or(Conversation.where(recipient_id: current_user.id)).order(updated_at: :desc)
	end

	private

	def conversation_params
		params.require(:conversation).permit(:recipient_id, :world_id, :title)
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