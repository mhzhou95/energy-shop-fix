class ItemsController < ApplicationController
	before_action :authenticate_admin, only: [:new, :create]
	def index
		@energy_drinks = Item.all
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(item_params)
		if @item.save
			redirect_to root_path
		else
			flash[:message] ="fail"
			redirect_to new_item_path
	
		end
	end

	private
	
	def item_params
		params.require(:item).permit(:name, :description, :price, :image, :quantity, :totalprice)
	end


end
