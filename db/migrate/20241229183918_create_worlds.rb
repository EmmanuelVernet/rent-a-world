class CreateWorlds < ActiveRecord::Migration[8.0]
  def change
    create_table :worlds do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :category
      t.string :place
      t.float :price
      t.text :description
      t.integer :capacity
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
