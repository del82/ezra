class Static < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :content, :slug, :title
  friendly_id :slug, use: :slugged
end
