class AddKeyToVehicle < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :vehicles, :users
  end
end
