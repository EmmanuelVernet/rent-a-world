class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.references :world, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.string :title

      t.timestamps
    end

    # index conversation to avoid duplicate threads for two users in a world
    add_index :conversations, [:sender_id, :recipient_id, :world_id], unique: true
  end
end