class ReservationsController < ApplicationController
	before_action :require_login

	def preload
		listing = Listing.find(params[:listing_id])
		today = Date.today
		reservations = listing.reservations.where("start_date >= ? OR end_date >= ?", today, today)

		render json: reservations	
	end

	def preview
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json: output
	end

	def create
		@reservation = current_user.reservations.new(reservation_params)
		customer = current_user 
		host = @reservation.listing.user
		reservation = @reservation

		respond_to do |format|

			if @reservation.save
				ReservationJob.perform_later(customer, host, reservation)
				format.html {redirect_to reservation_review_path(listing_id: @reservation.listing_id) }
			else
				redirect_to @reservation.listing
			end
		end
	end


	def review
		@reservation = Reservation.find_by(listing_id: params[:listing_id])
		@duration = (@reservation.end_date.to_date - @reservation.start_date.to_date).to_i
		@reservation.total = @reservation.price * @duration
	end

	private

	def is_conflict(start_date, end_date)
		listing = Listing.find(params[:listing_id])

		check = listing.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
		check.size > 0? true : false
	end

	def reservation_params
		params.require(:reservation).permit(:start_date,:end_date,:price, :total, :listing_id)
	end
end
