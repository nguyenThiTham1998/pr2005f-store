class ProductDetail < ApplicationRecord
  scope :display_by_color, ->(color){where("color like ?", color)}  
  has_many :order_details
  belongs_to :product
  has_many :cart_products
  has_many :cart, through: :cart_products 
  before_save :down_case_color
  enum size: Settings.size
  scope :display_by_color, ->(color){where("color like ?", color)}
  validates :price, presence: true, numericality: { only_integer: true }
  validate :max_price
 
  def max_price
      errors.add(:price, "The price must be greater than 1000")
      unless price > 1000?
  end
 
  def discount_price
    if self.discount.present?
        self.price -= self.price* self.discount / 100
    else
       self.price 
    end
  end
 
  private 	
		def down_case_color
		  self.color = color.downcase
		end	

end
