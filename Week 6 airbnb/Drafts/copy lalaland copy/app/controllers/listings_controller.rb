class ListingsController < ApplicationController
	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.new(strong_params)

		if @listing.save
			redirect_to user_listing_path(@listing.user, @listing)
			# redirect_to [@listing.user, @listing]
		else
			redirect_to 'home/index'
		end
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def index
	    listings_per_page = 7
	    params[:page] = 1 unless params[:page]
	    first_listing = (params[:page].to_i - 1 ) * listings_per_page
	    listings = Listing.all
	    @total_pages = listings.count / listings_per_page
	    if listings.count % listings_per_page > 0
	      @total_pages += 1
	    end
	    @listings = listings[first_listing...(first_listing + listings_per_page)]
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		arr = params[:listing].delete(:remove_selected_images)
		@listing.remove_selected_images = arr.map(&:to_i) unless arr.blank?

	    if @listing.update(strong_params)
	    	flash[:success] = 'Successfully updated.'
	      redirect_to '/home/index'
	    else
	      render 'edit'
	    end
	end


	def destroy

		@listing = Listing.find(params[:id])
	   if @listing.destroy
	   		flash[:success] = "listing deleted"
	   		redirect_to own_listing_user_path(current_user)
	   else
	   		redirect_to own_listing_user_path(current_user)
	   end
	end


	private

	def strong_params
		params.require(:listing).permit(:name, :prop_type, :room_type, :price, :availability, :location, :remove_images, {images: []}, {remove_selected_images: []}, amenity_ids: [])
	end
end
