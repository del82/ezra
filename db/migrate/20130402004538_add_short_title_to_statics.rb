class AddShortTitleToStatics < ActiveRecord::Migration
  def change
    add_column :statics, :short_title, :text
  end
end
