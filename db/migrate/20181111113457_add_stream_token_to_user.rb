class AddStreamTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stream_token, :string
    add_index :users, :stream_token, unique: true

    Users.all do |user|
      user.regenerate_stream_token
    end
  end
end
