class Admin::UsersController < Admin::ApplicationController

	def index
		if params[:val] == "largest"
			@users = User.all.order_by_orders.paginate(:page => params[:page], :per_page => Settings.limit_user)
		elsif params[:val] == "oldest"           
			@users = User.all.paginate(:page => params[:page], :per_page => Settings.limit_user)
		else 
			@users = User.all.order_by_time.paginate(:page => params[:page], :per_page => Settings.limit_user)
		end
	end	

	def show
		@user = User.find_by(id: params[:id])
		if @user.nil?
			flash[:danger] = t ".not_found_user"
			render 'index'
		else
			@orders = @user.orders.paginate(:page => params[:page], :per_page => Settings.limit_user_orders)	
			@comments = @user.comments.paginate(:page => params[:page], :per_page => Settings.limit_user_comments)	
			@type = params[:type]
		end 
	end

end	