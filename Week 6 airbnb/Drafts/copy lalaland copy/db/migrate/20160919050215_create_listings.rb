class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.integer :prop_type
      t.integer :room_type
      t.string :amenities
      t.string :price
      t.string :availability
      t.string :location
      t.references :user
      t.timestamps null: false
    end
  end
end
