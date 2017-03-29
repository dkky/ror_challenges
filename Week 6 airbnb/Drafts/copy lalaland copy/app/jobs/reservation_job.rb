class ReservationJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :default

  def perform(customer, host, reservation)
    # Do something later
    	ReservationMailer.booking_email(customer, host, reservation).deliver_now
		ReservationMailer.listing_email(customer, host, reservation).deliver_now
  end
end
