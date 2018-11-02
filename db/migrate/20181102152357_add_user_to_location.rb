class AddUserToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :user, foreign_key: true
  end
end
