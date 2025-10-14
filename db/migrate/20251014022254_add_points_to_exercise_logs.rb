class AddPointsToExerciseLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :exercise_logs, :points, :integer, null: false, default: 0
  end
end
