class AddParametersToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :provider, :string
    add_column :locations, :battery, :float
  end
end
