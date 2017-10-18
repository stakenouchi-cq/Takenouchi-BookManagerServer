class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	has_many :books

	before_save {self.email = email.downcase}
	after_create :update_access_token!

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
  			uniqueness: {case_sensitive: false}, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  # has_secure_password
  # has_secure_token :token

  def update_access_token!
    self.token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

end
