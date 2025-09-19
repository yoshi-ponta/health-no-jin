class CreateExerciseItems < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_items do |t|
      t.string :name, null: false
      t.integer :base_points, null: false
      t.timestamps
    end
  end
end
