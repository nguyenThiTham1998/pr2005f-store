class AddDeletedAtToProductDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :product_details, :deleted_at, :datetime
    add_index :product_details, :deleted_at
  end
end
