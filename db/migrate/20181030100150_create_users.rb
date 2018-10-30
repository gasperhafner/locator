class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :magic_link_token
      t.datetime :magic_link_token_expiration

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
