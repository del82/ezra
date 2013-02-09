class Feature < ActiveRecord::Base
  attr_accessible :instructions, :name
  belongs_to :user, :inverse_of => :features

  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 4, maximum: 25 }
  validates :instructions, presence: true
end
