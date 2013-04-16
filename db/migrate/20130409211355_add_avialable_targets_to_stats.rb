class AddAvialableTargetsToStats < ActiveRecord::Migration
  def change
    add_column :stats, :availableTargets, :array
  end
end
