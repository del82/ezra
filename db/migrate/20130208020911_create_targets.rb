class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :target_string
      t.integer :user_id

      t.timestamps
    end
    add_index :targets, :user_id
    add_index :targets, :target_string
    add_index :targets, :created_at
  end
end
