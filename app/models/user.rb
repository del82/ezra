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

  has_many :targets,  :inverse_of => :user
  has_many :features, :inverse_of => :user

  before_save do 
    self.email.downcase!
    self.username.downcase!

  end
  
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 20, minimum: 3 },
                       uniqueness: { case_sensitive: false }
  # no password presence validation in order to avoid duplicate error messages
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
