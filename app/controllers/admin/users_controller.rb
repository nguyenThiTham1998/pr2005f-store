class Admin::UsersController < Admin::ApplicationController

	def show
		@user = User.find_by(id: params[:id])
		if params[:type]=="orders"
			@orders = @user.orders
		else
			
			@comments = @user.comments
			
		end
	end
	
	def index
		@users = User.all.order_by_time
	end	

end	
