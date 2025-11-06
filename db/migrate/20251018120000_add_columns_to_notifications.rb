class AddColumnsToNotifications < ActiveRecord::Migration[8.0]
  def change
    change_table :notifications do |t|
      t.bigint :user_id,  null: false
      t.bigint :actor_id, null: false
      t.string :notifiable_type, null: false
      t.bigint :notifiable_id,   null: false
      t.string   :body
      t.datetime :read_at
    end

    add_foreign_key :notifications, :users, column: :user_id
    add_foreign_key :notifications, :users, column: :actor_id
  end
end
