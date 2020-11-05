class Product < ApplicationRecord
	acts_as_paranoid
	has_many :order_details
	has_many :product_details,dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many_attached :image
	scope :order_by_time,->{ order(created_at: :desc) }
  	accepts_nested_attributes_for :product_details, reject_if: :all_blank, allow_destroy: true
	enum classify: Settings.classify 
	enum product_type: Settings.product_type
	extend FriendlyId
	friendly_id :name, use: :slugged

	def should_generate_new_friendly_id?
	    name_changed? || super
	end

end
