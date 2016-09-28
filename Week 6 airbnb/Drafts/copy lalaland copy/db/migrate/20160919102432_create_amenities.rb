class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.string :name 
      t.string :description
      t.string :note
      t.timestamps null: false
    end
  end
end
