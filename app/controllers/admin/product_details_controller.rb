class Admin::ProductDetailsController < Admin::ApplicationController
	before_action :find_product_detail, only: [:edit, :update]
	def show
	end	
	def edit		
	end
	def update
		if @product_detail.update!(product_detail_params)
			redirect_to admin_product_path(@product_detail.product)
		else 
			flash[:danger] = t ".not_updated"
			render :edit
	end		
	end	
	private
	def product_detail_params
		params.require(:product_detail).permit(:color, :size)
	end		
	def find_product_detail
		@product_detail = ProductDetail.find_by id: params[:id]
		if @product_detail.nil?
			flash[:danger] = t ".not_found"
			render 'index'
		end
	end	
end
 
 