class CreateCheers < ActiveRecord::Migration[8.0]
  def change
    create_table :cheers do |t|
      t.references :group, null: false, foreign_key: true
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.references :to_user, null: false, foreign_key: { to_table: :users }
      t.date :cheered_on, null: false
      t.timestamps
    end
  end
end
