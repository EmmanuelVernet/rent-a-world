class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.bigint :sender, null: false, foreign_key: { to_table: :users}
      t.text :body, null: false
      t.datetime :read_at

      t.timestamps
    end
  end
end
