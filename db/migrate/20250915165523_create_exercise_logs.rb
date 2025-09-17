class CreateExerciseLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :item_id, null: false
      t.integer :amount, null: false
      t.datetime :performed_at, null: false

      t.timestamps
    end
  end
end
