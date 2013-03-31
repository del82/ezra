class AddSlugIndex < ActiveRecord::Migration
  def up
  	add_index :statics, :slug, unique: true
  end

  def down
  end
end
