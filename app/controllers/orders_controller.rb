class OrdersController < ApplicationController
	before_action :find_order, only: [:show, :update]
	before_action :authenticate_user!
	def new

		@order = Order.new
		@order.order_details.new
	end
	def index
		orders= Order.all
	end
	def show
	end

	def create
		pr = order_params.merge(order_status: order_params[:order_status].to_i)
		@order = Order.new pr
		if @order.save!
			redirect_to @order,notice: t('orders.create.notice')
			if current_user.address.nil?
				current_user.update(address:@order.address)
			elsif current_user.phone.nil?
				current_user.update(phone:@order.phone)
			elsif (current_user.address&&current_user.phone).nil?
				current_user.update(address:@order.address,phone:@order.phone)
			end
			current_cart.destroy
			session[:cart_id] = nil
			cookies.signed[:cart_id] = nil
		else
			redirect_to new_order_path
		end

	end

	def edit
	end
	def update
		if @order.Cancelbuyer!
			if current_user.admin?
				redirect_to admin_orders_path
			else
				render json: {   
			      order_status:  @order.order_status
		      	}, status: :ok 
			end
			
		end
		
	end

	private
	  def find_order
	  	@order = Order.find_by id:params[:id]
	  	if @order.nil?
	  		redirect_to root_path, notice: t('orders.show.notice')
	  	end
	  end
	  def order_params
	    params.require(:order).permit(:user_id, :total_price,
										  :address, :phone, :order_status, order_details_attributes: [:quality, :order_id,:product_detail_id ])
	  end
	  def user_params
	  	params.require(:user).permit(:address, :phone)
	  end
end
