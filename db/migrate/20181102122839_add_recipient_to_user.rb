class AddRecipientToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :recipient, :text
  end
end
