class RenameUserField < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :bullet_push_token, :pushbullet_token
    add_index :users, :pushbullet_token, unique: true
  end
end
