class AddNotesToHit < ActiveRecord::Migration
  def change
    add_column :hits, :notes, :text
  end
end
