class AddUserToPushLogs < ActiveRecord::Migration[5.1]
  def change
    add_reference :push_logs, :user, foreign_key: true
  end
end
