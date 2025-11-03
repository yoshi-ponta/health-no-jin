class TightenExerciseItemsNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :exercise_items, :category,   false
    change_column_null :exercise_items, :icon,       false
    change_column_null :exercise_items, :detail_key, false
    change_column_null :exercise_items, :name,       false
    change_column_null :exercise_items, :base_points, false
  end
end
