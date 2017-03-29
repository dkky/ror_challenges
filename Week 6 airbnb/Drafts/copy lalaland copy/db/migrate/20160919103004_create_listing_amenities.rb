class CreateListingAmenities < ActiveRecord::Migration
  def change
    create_table :listing_amenities do |t|
      t.references :listing
      t.references :amenities
      t.timestamps null: false
    end
  end
end
