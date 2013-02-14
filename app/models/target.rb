# == Schema Information
#
# Table name: targets
#
#  id         :integer          not null, primary key
#  phrase     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Target < ActiveRecord::Base
  attr_accessible :phrase
  belongs_to :user, :inverse_of => :targets
  has_and_belongs_to_many :features
  has_many :hits

  validates :user_id, presence: true
  validates :phrase, presence: true, length: { maximum: 30 } 
  default_scope order: 'targets.created_at ASC'
end
