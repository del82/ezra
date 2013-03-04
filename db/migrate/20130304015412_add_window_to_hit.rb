class AddWindowToHit < ActiveRecord::Migration
  def change
    add_column :hits, :window_start, :float
    add_column :hits, :window_duration, :float
  end
end
