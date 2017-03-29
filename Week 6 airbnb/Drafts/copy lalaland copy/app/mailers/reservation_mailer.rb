class ReservationMailer < ApplicationMailer
	default from: '<lalaland@example.com>'
 
  def booking_email(customer, host, reservation)
    @customer = customer
    @host = host
    @reservation = reservation
    @url  = 'http://example.com/login'
    mail(to: @customer.email, subject: 'You Booked Your Place')
  end

  def listing_email(customer, host, reservation)
    @customer = customer
    @host = host
    @reservation_id = reservation.id
    @url  = 'http://example.com/login'
    mail(to: @host.email, subject: 'Someone Has Booked Your Place')
  end
end
