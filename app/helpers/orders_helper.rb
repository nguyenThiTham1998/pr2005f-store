module OrdersHelper
	def total_payment
		@sum = 0
			current_cart.content.each do |key,value|
				product_detail= ProductDetail.find_by id:key
				 @sum +=  product_detail.price*value.to_i
			end
		@sum
	end
	
end
