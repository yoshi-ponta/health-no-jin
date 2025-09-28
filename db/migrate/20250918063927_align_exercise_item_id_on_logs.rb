class AlignExerciseItemIdOnLogs < ActiveRecord::Migration[8.0]
  def change
    change_column :exercise_logs, :exercise_item_id, :bigint

    add_foreign_key :exercise_logs, :exercise_items, column: :exercise_item_id, validate: false unless
      foreign_key_exists?(:exercise_logs, :exercise_items, column: :exercise_item_id)

    add_index :exercise_logs, :exercise_item_id unless
      index_exists?(:exercise_logs, :exercise_item_id)
  end
end
