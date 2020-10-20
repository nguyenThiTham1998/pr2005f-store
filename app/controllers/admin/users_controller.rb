class Admin::UsersController < Admin::ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find_by(id: params[:id])
		if params[:type]=="orders"
			@orders = @user.orders
		else
			
			@comments = @user.comments
			
		end
	end
end
