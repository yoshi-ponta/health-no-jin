class FixExerciseLogsRenameAndKeys < ActiveRecord::Migration[8.0]
  def change
    if column_exists?(:exercise_logs, :item_id)
      rename_column :exercise_logs, :item_id, :exercise_item_id
    end
  end
end