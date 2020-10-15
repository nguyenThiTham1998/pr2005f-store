class ProductDetailsController < ApplicationController
	def index
		@product = Product.find_by id: params[:product_id]
		@product_details = @product.product_details.where("color=?", params[:color])
		render json:{
			data_color: @sizes =  @product_details.pluck(:size).uniq
		},status: :ok
	end	
end
