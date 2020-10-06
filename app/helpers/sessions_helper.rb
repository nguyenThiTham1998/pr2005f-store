module SessionsHelper

	def current_cart
		
	 	 if session[:cart_id].present? 
		 		@current_cart = Cart.find_by id: session[:cart_id] 
		 elsif cookies.permanent.signed[:cart_id].present?
		 		@current_cart = Cart.find_by id: cookies.signed[:cart_id]

		 else 
 			cart = Cart.create
 	  		session[:cart_id] = cart.id
	 		cookies.permanent.signed[:cart_id] = cart.id
	 		@current_cart = cart
		end	 	
		@current_cart
	end
end
