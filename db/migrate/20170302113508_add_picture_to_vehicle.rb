class AddPictureToVehicle < ActiveRecord::Migration[5.0]
  def change
    add_column :vehicles, :pictures, :json
  end
end
