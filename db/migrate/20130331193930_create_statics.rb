class CreateStatics < ActiveRecord::Migration
  def change
    create_table :statics do |t|
      t.string :title
      t.text :content
      t.string :slug

      t.timestamps
    end
  end
end
