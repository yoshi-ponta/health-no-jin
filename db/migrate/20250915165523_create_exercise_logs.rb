class CreateExerciseLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exercise_item, null: false, foreign_key: true
      t.integer :amount, null: false
      t.datetime :performed_at, null: false

      t.timestamps
    end

    add_index :exercise_logs, :performed_at
    add_index :exercise_logs, [ :user_id, :performed_at ]
  end
end
