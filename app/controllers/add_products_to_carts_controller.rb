class AddProductsToCartsController < ApplicationController
	before_action :authenticate_user!
	
	def update

		@product_detail = ProductDetail.find_by product_id: params[:id], size: params[:size], color: params[:color]
		if @product_detail.present?
			id_product_detail = @product_detail.id
			quantity_product_detail = params[:quantity]
			@hash_content = current_cart.content
		
			if @hash_content.nil?
				@hash_content ={"#{id_product_detail}": quantity_product_detail}			
			elsif @hash_content.has_key?("#{id_product_detail}")&& params[:cart_identy].nil?
				@old_quantity = current_cart.content["#{id_product_detail}"]
				@hash_content[:"#{id_product_detail}"] = quantity_product_detail.to_i + @old_quantity.to_i
			else
				@hash_content[:"#{id_product_detail}"] = quantity_product_detail
			end
			current_cart.update!(content: @hash_content, user_id: current_user.id)


			@quantity = current_cart.content["#{id_product_detail}"]

			 render json:  {
			    "success": true,
			     "value": [{
			     	
			       "quantity": @quantity,
			       "success": "ok",
			       "code": "200"       
			     }]
			}
				 	  
		 else
		 	render json:  {
			     "success": false,
			     "errors": [{
			       "message": "Vui long chon phan loai san pham"   
			     }]
			}

		 end
	end

	def destroy
		id_product_detail = params[:id]
		@hash_content = current_cart.content.reject!{|key, value| key == "#{id_product_detail}"}
		if @hash_content.empty?
			@hash_content =  nil
		end
		current_cart.update!(content: @hash_content)
		flash.now[:success] = "san pham xoa thanh cong "
		render json: {   
	      current_cart:  current_cart
      	}, status: :ok 
	end

end

