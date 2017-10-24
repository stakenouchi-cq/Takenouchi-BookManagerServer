class User < ApplicationRecord
  # Include default devise modules.
  has_many :books
  devise :database_authenticatable, :Rememberable

  before_save { self.email = email.downcase }
  after_create :generate_token # ユーザー新規作成後、トークンを生成

  def ensure_token
    # トークンが、nilでないかチェックを行う
    # nilであれば、トークンの生成を行う(nilでなければ、トークンに変更を加えず終了)
    self.token || generate_token
  end

  def generate_token
    loop do
      current_token = self.token
      new_token = SecureRandom.urlsafe_base64(30).tr('lIO0', 'sxyz')
      # トークンの更新に成功し、前のトークンと違うものになっていれば成功なので、終了
      break new_token if (self.update!(token: new_token) rescue false) && current_token != new_token
    end
  end

  def trash_token
    # ログアウト時にトークンを破棄
    self.update(token: nil)
  end
end
