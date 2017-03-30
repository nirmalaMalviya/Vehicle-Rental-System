class AddToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :roll_type, :integer
  end
end
