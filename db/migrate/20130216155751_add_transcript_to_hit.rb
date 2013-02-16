class AddTranscriptToHit < ActiveRecord::Migration
  def change
    add_column :hits, :transcript, :text
  end
end
