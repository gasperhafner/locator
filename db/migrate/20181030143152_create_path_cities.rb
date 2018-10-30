class CreatePathCities < ActiveRecord::Migration[5.1]
  def change
    create_table :path_cities do |t|
      t.references :path, foreign_key: true
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
