# == Schema Information
#
# Table name: hits
#
#  id              :integer          not null, primary key
#  location        :float
#  confirmed       :integer
#  flagged         :boolean
#  audio_file      :string(255)
#  target_id       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  transcript      :text
#  feat_vals       :text
#  window_start    :float
#  window_duration :float
#

class Hit < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :audio_file, :confirmed, :flagged
  attr_accessible :location, :transcript, :feat_vals
  attr_accessible :window_start, :window_duration, :notes
  serialize :feat_vals, Hash

  belongs_to :target, :inverse_of => :hits
  has_many :features, :through => :target

  validates :audio_file, presence: true
  validates :confirmed, presence: true, numericality: { only_integer: true,
                                                        greater_than: -3,
                                                        less_than:     2 }
  validates :location, presence: true, numericality: { greater_than: 0 }
  validates :target_id, presence: true
  validates :window_start, numericality: { greater_than_or_equal_to: 0, }
  validates :window_duration, numericality: { greater_than: 0, }

end
