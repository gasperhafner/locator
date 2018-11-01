class AddUserToCity < ActiveRecord::Migration[5.1]
  def change
    add_reference :cities, :user, foreign_key: true
  end
end
