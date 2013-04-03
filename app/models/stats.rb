# == Schema Information
#
# Table name: stats
#
#  id         :integer          not null, primary key
#  recent     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Stats < ActiveRecord::Base
  attr_accessible :recent

  belongs_to :users
end
