class Target < ActiveRecord::Base
  attr_accessible :target_string
  belongs_to :user, :inverse_of => :targets

  validates :user_id, presence: true
  validates :target_string, presence: true, length: { maximum: 30 } 
  default_scope order: 'targets.created_at ASC'
end
