class Order < ApplicationRecord
	has_many :order_details
	belongs_to :user
	scope :count_order, -> {where('created_at >=?', 24.hour.ago)}
end
