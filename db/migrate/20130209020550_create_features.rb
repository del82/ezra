class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :user_id
      t.string :name
      t.text :instructions

      t.timestamps
    end

    add_index :features, :user_id
    add_index :features, :name
  end
end
