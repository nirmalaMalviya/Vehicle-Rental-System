class AddFieldToBookVehicle < ActiveRecord::Migration[5.0]
  def change
  	add_column :book_vehicles, :date_of_booking, :datetime
  	add_column :book_vehicles, :date_of_release, :datetime
  end
end
