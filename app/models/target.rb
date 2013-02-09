class Target < ActiveRecord::Base
  attr_accessible :phrase
  belongs_to :user, :inverse_of => :targets
  has_and_belongs_to_many :features

  validates :user_id, presence: true
  validates :phrase, presence: true, length: { maximum: 30 } 
  default_scope order: 'targets.created_at ASC'
end
