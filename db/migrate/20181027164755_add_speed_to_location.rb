class AddSpeedToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :speed, :float
    add_column :locations, :time, :datetime
  end
end
