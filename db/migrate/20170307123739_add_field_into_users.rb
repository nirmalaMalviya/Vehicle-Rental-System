class AddFieldIntoUsers < ActiveRecord::Migration[5.0]
  def change
  	  add_column :users, :show_image, :integer
  end
end
