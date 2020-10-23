class Product < ApplicationRecord

	has_many :order_details
	has_many :product_details,dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many_attached :image
	scope :order_by_time,->{ order(created_at: :desc) }
	scope :search_product, lambda{|search|
    	search&.squish! if search
    	ransack(name_or_classify_cont: search).result
  	}
  	accepts_nested_attributes_for :product_details, reject_if: :all_blank, allow_destroy: true
	enum classify: Settings.classify 
	enum product_type: Settings.product_type

end
