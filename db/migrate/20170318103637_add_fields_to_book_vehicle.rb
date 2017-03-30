class AddFieldsToBookVehicle < ActiveRecord::Migration[5.0]
  def change
  	add_column :book_vehicles, :user_id, :integer
  	add_column :book_vehicles, :vehicle_id, :integer
  end
end
