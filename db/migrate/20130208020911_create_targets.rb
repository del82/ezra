class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :phrase
      t.integer :user_id

      t.timestamps
    end
    add_index :targets, :user_id
    add_index :targets, :phrase
    add_index :targets, :created_at
  end
end
