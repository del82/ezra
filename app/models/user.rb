# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      default(""), not null
#  username               :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  include PublicActivity::Common

  # Include default devise modules. Others available are:
  # :token_authenticatable, :omniauthable
  devise :database_authenticatable, :timeoutable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :lockable

  attr_accessible :name, :username, :email, :password,
                  :password_confirmation, :remember_me
  # Virtual attribute for authenticating by either username or email
  attr_accessor :login
  attr_accessible :login


  has_many :targets,  :inverse_of => :user
  has_many :features, :inverse_of => :user
  has_one :stats

  before_save do
    self.email.downcase!
    self.username.downcase!

  end

  #before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 20, minimum: 3 },
                       uniqueness: { case_sensitive: false }
  # no password presence validation in order to avoid duplicate error messages
  # validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  # redefine devise method to allow authentication by username or password
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
