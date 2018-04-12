class CartsController < ApplicationController
	def show
		@user = current_user
		@cart = Cart.find_by_id(session[:cart_id])
		@stripe_pay = @cart.totalcost * 100
	end

	def new
		@user = current_user.id

	end

	def add_item
		item = Item.find_by_id(params[:itemid])
		cart = Cart.find_by_id(session[:cart_id])
		item.quantity = params[:quantity]
		item.totalprice = (item.price * item.quantity)
		if cart.items.include?(item) == false
		cart.items << item
		temp = cart.totalcost + (item.price * item.quantity)
		cart.update(totalcost: temp)
		flash[:message] = "#{item.name} succesfully added to cart"
		redirect_to root_path
		else
			flash[:message] = "#{item.name} already in cart"
			redirect_to root_path
		end
	end

	def delete_item
		item = Item.find_by_id(params[:itemid])
		cart = Cart.find_by_id(session[:cart_id])
		if cart.items.destroy(params[:itemid])
			temp = cart.totalcost - (item.price * item.quantity)
			cart.update(totalcost: temp)
		flash[:message]= "item removed from cart"
		redirect_back(fallback_location: root_path)
		end
	end

end
