class AddProductDetailIdToOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :order_details, :product_detail_id, :integer, foreign_key: true
  end
end
