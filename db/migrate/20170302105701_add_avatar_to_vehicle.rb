class AddAvatarToVehicle < ActiveRecord::Migration[5.0]
  def change
    add_column :vehicles, :avatar, :string
  end
end
