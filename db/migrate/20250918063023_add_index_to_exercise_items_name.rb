class AddIndexToExerciseItemsName < ActiveRecord::Migration[8.0]
  def change
    add_index :exercise_items, :name unless index_exists?(:exercise_items, :name)
  end
end
