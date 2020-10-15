class ProductsController < ApplicationController

	before_action :find_product, only: :show
	def index
		@products = Product.send(params["classify"])
		render json: {
			data_products: render_to_string(@products)
		}, status: :ok

	end	
	def show

		@supports = Supports::Product.new @product
		if current_user.present?
			@comment = current_user.comments.build
		end
		@comments = @product.comments.paginate(page: params[:page])
		
		@product_details = @product.product_details

	end
	
	private
	def find_product
		@product = Product.find_by id: params[:id]
		if @product.nil?
			redirect_to root_url
			flash[:danger] = t ".not_updated"
		end
	end			

end
