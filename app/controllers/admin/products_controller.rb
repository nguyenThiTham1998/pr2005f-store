class Admin::ProductsController < Admin::ApplicationController

	def index
	end

    def new
    	@product = Product.new
    	@product_detail = @product.product_details.build
        @size = params[:size_id]
    end

    def create
    	
    end

  	

end
