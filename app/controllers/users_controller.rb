class UsersController < ApplicationController
	before_action :check_login, only: :new
	 def show
	 	@user = User.find_by id: params[:id]
	 	if @user.nil?
 			flash[:danger] = "user not found"
 			redirect_to root_url
 		else
		 	if params[:order_id].present?
		 		@orders= @user.orders
		 		render json: {
					data_orders: render_to_string(@orders)
				}, status: :ok
			
			elsif params[:address_id].present?
				render json: {
					data_address: render_to_string(@user)
				}, status: :ok
			elsif params[:account_id].present?
				render json: {
					data_add: render_to_string(@user)
				}, status: :ok
			end
				
	 	end

	 end

	 private 
	 def check_login
	 	if user_signed_in? 
	 		flash[:danger] = "you are logging"
	 		redirect_to root_url
	 	end	
	 end 
	
end
