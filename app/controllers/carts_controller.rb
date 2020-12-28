class CartsController < ApplicationController

	def index
		
		if current_cart.content.nil?
			redirect_back fallback_location: current_cart, notice: t("carts.index.notice")

		end
	end

	def show
	end
	def create
	end

end
