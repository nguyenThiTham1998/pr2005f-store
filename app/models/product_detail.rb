class ProductDetail < ApplicationRecord
  belongs_to :product
  enum size_id: {"S" => 0, "M" => 1, "L" => 2}
end
