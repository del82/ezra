class CreateFeaturesTargetsJoinTable < ActiveRecord::Migration
  def change
    create_table :features_targets, :id => false do |t|
      t.integer :feature_id
      t.integer :target_id
    end
    add_index :features_targets, :feature_id
    add_index :features_targets, :target_id
  end
end
