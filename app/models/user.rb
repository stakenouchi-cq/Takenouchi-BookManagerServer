class User < ApplicationRecord
  # Include default devise modules.
  has_many :books
  devise :database_authenticatable, :Rememberable

  before_save {self.email = email.downcase}
  after_create :update_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
        uniqueness: {case_sensitive: false}, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}

  def update_token
    # アカウント新規作成時やログアウト後によりトークンがnullであれば、新たなトークンを生成
    self.update_attribute(:token, "#{ self.token || Devise.friendly_token }")
  end

  def trash_token
    # ログアウト時にトークンを破棄
    self.update(token: nil)
  end
end
