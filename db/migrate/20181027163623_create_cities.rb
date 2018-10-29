class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.geometry :polygon, limit: {:srid=>4326, :type=>"st_polygon"}
      t.timestamps
    end
  end
end
