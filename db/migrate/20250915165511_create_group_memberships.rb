class CreateGroupMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :group_memberships do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :group, null: false, foreign_key: true
      t.datetime :joined_at, null: false
      t.datetime :left_at

      t.timestamps
    end
    add_index :group_memberships, :group_id, if_not_exists: true
    add_index :group_memberships, :user_id, unique: true, where: "left_at IS NULL", name:  "index_group_memberships_on_user_id_active_unique", if_not_exists: true
  end
end
