class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
      t.float :location
      t.integer :confirmed
      t.boolean :flagged
      t.string :audio_file
      t.integer :target_id

      t.timestamps
    end

    add_index :hits, :confirmed
    add_index :hits, :flagged
    add_index :hits, :target_id
  end
end
