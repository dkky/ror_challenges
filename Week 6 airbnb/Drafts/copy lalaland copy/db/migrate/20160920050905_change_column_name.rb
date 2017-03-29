class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :listing_amenities, :amenities_id, :amenity_id
  end
end
