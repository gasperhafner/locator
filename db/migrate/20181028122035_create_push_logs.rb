class CreatePushLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :push_logs do |t|
      t.references :city, foreign_key: true
      t.string :sender
      t.string :receiver
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
