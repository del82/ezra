# == Schema Information
#
# Table name: stats
#
#  id               :integer          not null, primary key
#  recent           :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  availableTargets :array
#

class Stats < ActiveRecord::Base
  attr_accessible :recent, :availableTargets

  serialize :availableTargets, Array

  belongs_to :users
end
