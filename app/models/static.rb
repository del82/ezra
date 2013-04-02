class Static < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :title, :short_title, :content, :slug, :sort
  friendly_id :slug, use: :slugged

  validates :title,       presence: true
  validates :short_title, presence: true
  validates :content,     presence: true
  validates :slug,        presence: true
  validates :sort,        presence: true

end

