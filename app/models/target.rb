class Target < ActiveRecord::Base
  attr_accessible :target_string
  belongs_to :user
  validates :user_id, presence: true
end
