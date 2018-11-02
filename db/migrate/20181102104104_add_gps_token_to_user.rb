class AddGpsTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gps_token, :string
  end
end
