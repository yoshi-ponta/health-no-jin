class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.bigint :owner_id

      t.timestamps
    end
  end
end
