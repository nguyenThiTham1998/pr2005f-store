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
		@product_details = @product.product_details
		@comments = @product.comments.paginate(page: params[:page])

	end
	
	private
	def find_product
		@product = Product.find_by id: params[:id]
		if @product.nil?

			redirect_to root_url
			flash[:danger] = t ".not_updated"

			redirect_to root_url, notice: t('.notice')
			
		end
	end			

end
