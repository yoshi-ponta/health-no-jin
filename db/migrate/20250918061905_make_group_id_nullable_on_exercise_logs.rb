class MakeGroupIdNullableOnExerciseLogs < ActiveRecord::Migration[8.0]
  def change
    change_column_null :exercise_logs, :group_id, true
  end
end
