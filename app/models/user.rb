# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  username   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :username, :email, :password, :password_confirmation
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  before_save { |user| user.username = username.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 20, minimum: 3 },
                       uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

end
