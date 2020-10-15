class ProductDetail < ApplicationRecord
  belongs_to :product
  has_many :cart_products
  has_many :cart, through: :cart_products 
  before_save :down_case_color
  
  enum size: Settings.size
  scope :display_by_color, ->(color){where("color like ?", color)}
  
  private 	
		def down_case_color
		  self.color = color.downcase
		end	
end
