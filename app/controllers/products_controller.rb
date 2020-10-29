class ProductsController < ApplicationController
	before_action :find_product, only: :show
	def index
			
			@products = Product.send(params["classify"])
			render json: {
				data_products: render_to_string(@products.includes([:image_attachments]))
			}, status: :ok
	
	end	
	
  
	  def search_params
	    return nil unless params[:product_list]
	    params.require(:product_list).permit :name_or_classify
	  end
	def show

		@supports = Supports::Product.new @product
		if current_user.present?
			@comment = current_user.comments.build
		end

		@comments = @product.comments.paginate(page: params[:page])
		color = params['color']
		if color.present?
			@product_details = @product.product_details.display_by_color color
			render json:{
					data_color:  @product_details.pluck(:size).uniq,
					data_all: @product.product_details.pluck(:size).uniq
			},status: :ok
		else 
			@product_details = @product.product_details
		end
			
	end
	
	private
	def find_product
		@product = Product.find_by id: params[:id]
		if @product.nil?
			redirect_to root_url, notice: t('products.show.notice')
		end
	end			

end
