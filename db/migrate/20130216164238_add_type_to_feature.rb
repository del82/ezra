class AddTypeToFeature < ActiveRecord::Migration
  def change
    add_column :features, :ftype, :int
    add_index :features, :ftype
  end
end
