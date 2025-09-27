class ValidateFkOnExerciseLogs < ActiveRecord::Migration[8.0]
  def up
    execute <<~SQL
      INSERT INTO exercise_items (id, name, base_points, created_at, updated_at)
      SELECT DISTINCT l.exercise_item_id, 'MIGRATED', 1, NOW(), NOW()
      FROM exercise_logs l
      LEFT JOIN exercise_items i ON i.id = l.exercise_item_id
      WHERE l.exercise_item_id IS NOT NULL AND i.id IS NULL;
    SQL

    validate_foreign_key :exercise_logs, :exercise_items
  end

  def down
  end
end
