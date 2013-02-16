# == Schema Information
#
# Table name: hits
#
#  id         :integer          not null, primary key
#  location   :float
#  confirmed  :integer
#  flagged    :boolean
#  audio_file :string(255)
#  target_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Hit < ActiveRecord::Base
  attr_accessible :audio_file, :confirmed, :flagged, :location, :transcript
  
  belongs_to :target, :inverse_of => :hits

  validates :audio_file, presence: true
  validates :confirmed, presence: true, numericality: { only_integer: true,
                                                        greater_than: -3,
                                                        less_than:     2 }
  validates :location, presence: true, numericality: { greater_than: 0 }
  validates :target_id, presence: true

end
