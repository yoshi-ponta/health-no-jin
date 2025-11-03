class DropExerciseCategories < ActiveRecord::Migration[8.0]
  def change
    drop_table :exercise_categories, if_exists: true
  end
end
