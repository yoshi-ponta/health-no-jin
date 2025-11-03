class CreateExerciseCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_categories do |t|
      t.string :key, null: false
      t.string :name, null: false
      t.string :icon, null: false

      t.timestamps
    end
    add_index :exercise_categories, :key, unique: true
  end
end
