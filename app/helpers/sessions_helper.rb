module SessionsHelper

	def current_cart
		if current_user.present?
			if cookies.permanent.signed[:cart_id].present?
			 		cart = Cart.find_by id: cookies.signed[:cart_id]
			elsif current_user.cart.present? 
				cart = current_user.cart
			else	
				cart = Cart.new
				cart.user = current_user
				cart.save!
			end		
  		    session[:cart_id] = cart.id
			cookies.permanent.signed[:cart_id] = cart.id
			@current_cart = cart
		end	
			@current_cart
	end

end
