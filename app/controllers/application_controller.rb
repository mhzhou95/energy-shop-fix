class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
before_action :set_cart


def set_cart 
	   if @cart = Cart.find_by_id(session[:cart_id])
  		@cart = Cart.find_by_id(session[:cart_id]) 
  	end
  	
  	if @cart = Cart.find_by_id(session[:cart_id]).nil?
		@cart = Cart.create(totalcost: 0)
  		session[:cart_id] = @cart.id
  	end
  	@cart
end
def authenticate_admin
  unless current_user == User.find_by_id(1)
    redirect_to "/"
    flash[:message] = "You dont not have permission"
  end
end

end
