class Order < ApplicationRecord
	has_many :order_details
	belongs_to :user
	scope :count_order, -> {where('created_at >=?', 24.hour.ago)}
 	scope :order_by_time, -> (val){order(created_at: :desc) if val == "newest"}
 	scope :status, -> (order_status) {where(order_status: order_status)}
 	enum order_status: Settings.order_status  	
end

