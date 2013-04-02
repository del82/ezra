class AddSortToStatic < ActiveRecord::Migration
  def change
    add_column :statics, :sort, :integer
    add_index :statics, :sort, order: { sort: :asc }
  end
end
