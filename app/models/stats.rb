class Stats < ActiveRecord::Base
  attr_accessible :recent

  belongs_to :users
end