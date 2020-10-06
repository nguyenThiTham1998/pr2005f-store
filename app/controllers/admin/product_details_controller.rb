class Admin::ProductDetailsController < Admin::ApplicationController
	
	def new
		@product_detail = ProducDetail.new
	end

end