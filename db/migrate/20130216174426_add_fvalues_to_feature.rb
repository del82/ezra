class AddFvaluesToFeature < ActiveRecord::Migration
  def change
    add_column :features, :fvalues, :text
  end
end
