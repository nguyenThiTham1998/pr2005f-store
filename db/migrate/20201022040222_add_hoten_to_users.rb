class AddHotenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hoten, :string
  end
end
