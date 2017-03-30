class Changecolumnnamevehicle < ActiveRecord::Migration[5.0]
  def changes
  	add_column :vehicles, :vtype, :string
  end
end
