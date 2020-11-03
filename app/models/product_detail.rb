class ProductDetail < ApplicationRecord
  acts_as_paranoid
  scope :display_by_color, ->(color){where("color like ?", color)}  
  has_many :order_details
  belongs_to :product
  has_many :cart_products
  has_many :cart, through: :cart_products 
  before_save :down_case_color
  enum size: Settings.size
  scope :display_by_color, ->(color){where("color like ?", color)}

 def discount_price
    if self.discount.present?
        self.price -= self.price* self.discount / 100
    else
       self.price 
    end
  end


  def self.to_csv
    attributes = %w{product_id color price size discount}

    CSV.generate do |csv|
    csv << attributes

      all.each do |product_detail|
        csv << product_detail.attributes.values_at(*attributes)
      end
    end
  end

 
  private 	
		def down_case_color
		  self.color = color.downcase
		end	

end



