class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :world, null: false, foreign_key: true
      t.text :comment
      t.integer :stars, default: 0

      t.timestamps
    end
  end
end
