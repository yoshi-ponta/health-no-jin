class ModifyExerciseItemsForSingleTable < ActiveRecord::Migration[8.0]
  def change
    add_column :exercise_items, :category,   :string, null: true
    add_column :exercise_items, :icon,       :string, null: true
    add_column :exercise_items, :detail_key, :string, null: true

    add_index :exercise_items, [ :category, :detail_key ], unique: true, name: "idx_items_category_detailkey"
    add_index :exercise_items, [ :category, :name ],       unique: true, name: "idx_items_category_name"
  end
end
