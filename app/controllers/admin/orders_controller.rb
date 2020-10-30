class Admin::OrdersController < Admin::ApplicationController

	def index
		val = if params[:val] == "oldest"
	            "oldest"
	         else
	             "newest"
	         end

		if params[:type].present?
			@orders = Order.status(params[:type].to_i).order_by_time(val).paginate(:page => params[:page], :per_page => Settings.limit_order)	
			@type = params[:type]		
		else
			@orders = Order.all.order_by_time(val).paginate(:page => params[:page], :per_page => Settings.limit_order)			
	    end	
	    @order_status = Order.order_statuses.reject{|k| k == "Canceled by buyer"}
	end

	 
	
	def update		
		pr = params[:id].split(",").map{ |id| id.to_i }
		if Order.update(pr, pr.map{ |id| {order_status: params[:order_status].to_i}})
			render json: {   
	        update_data_order: Order.find_by(id: pr.first).order_status
	    }, status: :ok  
		end
	end 


	def show
		@order = Order.find_by(id: params[:id])
		if @order.nil?
			flash[:danger] = 'Không tìm thấy chi tiết sản phẩm này'
			redirect_to admin_orders_path
		else
			@order_details = @order.order_details
			@user = User.find_by(id: @order.user_id)
		end
	    @product_details = @order.product_details

	    respond_to do |format|
	    	format.html
	    	format.csv { send_data @product_details.to_csv, filename: "order-#{Date.today}.csv"  }
	    end
	end
end 
