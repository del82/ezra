class AddFeatValsToHit < ActiveRecord::Migration
  def change
    add_column :hits, :feat_vals, :text
  end
end
