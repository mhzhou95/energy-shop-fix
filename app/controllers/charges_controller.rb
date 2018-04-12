class ChargesController < ApplicationController
  before_action :authenticate_user! 
	def new
    @cart = Cart.find_by_id(session[:cart_id])
    @temp = @cart.totalcost * 100
    @amount = @temp.to_i
	end

	def create
    @cart = Cart.find_by_id(session[:cart_id])
    str1 = ''
    @cart.items.each do |drinks|
      str1 += "item: #{drinks.name}\n"
      str1 += "price: #{drinks.price.to_s}\n"
      str1 += "quantity: #{drinks.quantity.to_s}\n"
      str1 += "totalcost: #{drinks.totalprice.to_s}\n"
    end
  	# Amount in cents
  	@temp = @cart.totalcost * 100
    @amount = @temp.to_i
  	customer = Stripe::Customer.create(
    	:email => params[:stripeEmail],
    	:source  => params[:stripeToken]
  	)

  	charge = Stripe::Charge.create(
    	:customer    => customer.id,
    	:amount      => @amount,
    	:description => "#{str1}",
    	:currency    => 'usd'
  	)
    
	rescue Stripe::CardError => e
  	flash[:error] = e.message
  	redirect_to new_charge_path
	end
 

  
end
