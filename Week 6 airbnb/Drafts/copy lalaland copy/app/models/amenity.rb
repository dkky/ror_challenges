class Amenity < ActiveRecord::Base
	has_many :listing_amenities, :dependent => :destroy
	has_many :listings, through: :listing_amenities, :dependent => :destroy
end
