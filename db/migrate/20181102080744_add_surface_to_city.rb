class AddSurfaceToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :surface, :float
  end
end
