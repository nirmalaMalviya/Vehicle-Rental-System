class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.integer :type
      t.string  :vno
      t.decimal :cost
      t.integer :seater
      t.integer :fueltype

      t.timestamps
    end
  end
end
