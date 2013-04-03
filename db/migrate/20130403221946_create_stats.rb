class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :recent
      t.integer :user_id

      t.timestamps
    end

    add_index :stats, :user_id
  end
end
