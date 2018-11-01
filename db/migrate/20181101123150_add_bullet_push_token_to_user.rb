class AddBulletPushTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bullet_push_token, :string
  end
end
