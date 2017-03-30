class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :dob, :string
    add_column :users, :user_image, :string
    
  end
end
