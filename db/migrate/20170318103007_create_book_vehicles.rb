class CreateBookVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :book_vehicles do |t|
      t.decimal :v_cost
      t.string :address

      t.timestamps
    end
  end
end
