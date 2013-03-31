class Static < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :content, :slug, :title
  friendly_id :title, use: :slugged
end
