class User < ApplicationRecord
	before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
  			uniqueness: {case_sensitive: false}, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}
  has_secure_password
  has_secure_token :token
end
