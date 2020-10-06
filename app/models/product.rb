class Product < ApplicationRecord
	has_many :order_details
	has_many :product_details
	has_many :comments
	enum classify: {"men" => 0, "woman" => 1, "kid" => 2}
end
