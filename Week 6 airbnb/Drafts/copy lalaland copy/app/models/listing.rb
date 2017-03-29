class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :listing_amenities,:dependent => :destroy
	has_many :amenities, through: :listing_amenities
	has_many :reservations, :dependent => :destroy

	mount_uploaders :images, ImageUploader

	PROP_TYPE = %w(Apartment House Condo).map {|x| [x] * 2}

	enum prop_type: [
		'Apartment',
		'House',
		'Condo'
	]

	ROOM_TYPE = %w(Entire\ Place Shared\ Room Private\ Room)


	enum room_type: {
		'Entire Place': 0,
		'Shared Room': 1,
		'Private Room': 2
	}

	def remove_selected_images=(arr)
		images = self.images
		arr.each do |el|
			images[el].remove!
		end
		self.images = images.reject.with_index { |_ , index| arr.include?(index) }
	end
end


