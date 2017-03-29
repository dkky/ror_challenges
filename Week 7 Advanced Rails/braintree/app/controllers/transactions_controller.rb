class TransactionsController < ApplicationController
  def client_token
  	 client_token = Braintree::ClientToken.generate
  	 render json: {client_token: client_token}
  end

  def check_out
  	byebug
  	nonce_from_the_client =  params[:checkout_form][:payment_method_nonce]
  	result = Braintree::Transaction.sale(
  		:amount => "10.00",
  		:payment_method_nonce => nonce_from_the_client,
  		:options =>{
  			:submit_for_settlement => true
  		}
  	)
  	transaction = result.transaction

  	redirect_to :root, flash: {notice: transaction && transaction.status}
  end
end
