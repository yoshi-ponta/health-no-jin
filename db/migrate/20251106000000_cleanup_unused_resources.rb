class CleanupUnusedResources < ActiveRecord::Migration[8.0]
  def up
    drop_table :messages, if_exists: true
    drop_table :tasks, if_exists: true
  end

  def down
    create_table :messages do |t|
      t.timestamps
    end

    create_table :tasks do |t|
      t.string :title
      t.timestamps
    end
  end
end
