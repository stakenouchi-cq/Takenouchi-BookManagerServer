class User < ApplicationRecord
  # Include default devise modules.
  has_many :books
  devise :database_authenticatable, :Rememberable

  before_save { self.email = email.downcase }
  after_create :update_token

  def update_token
    # アカウント新規作成時やログアウト後によりトークンがnullであれば、新たなトークンを生成
    unless self.update( token: self.token || SecureRandom.urlsafe_base64(n=30) )
      render_internal_server_error # サーバー内部のエラーでトークン更新失敗    
    end
  end

  def trash_token
    # ログアウト時にトークンを破棄
    self.update(token: nil)
  end
end
