class Hit < ActiveRecord::Base
  attr_accessible :audio_file, :confirmed, :flagged, :location
  
  belongs_to :target, :inverse_of => :hits

  validates :audio_file, presence: true
  validates :confirmed, presence: true, numericality: { only_integer: true,
                                                        greater_than: -3,
                                                        less_than:     2 }
  validates :location, presence: true, numericality: { greater_than: 0 }
  validates :target_id, presence: true

end
