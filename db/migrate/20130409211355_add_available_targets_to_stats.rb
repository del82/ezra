class AddAvailableTargetsToStats < ActiveRecord::Migration
  def change
    add_column :stats, :availableTargets, :text
  end
end
