class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, foreign_key: true
      t.integer :order_status, null: false, default: 0
      t.integer :total_price
      t.timestamps
    end
  end
end
