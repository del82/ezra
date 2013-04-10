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

require 'spec_helper'

describe Stats do
  pending "add some examples to (or delete) #{__FILE__}"
end
