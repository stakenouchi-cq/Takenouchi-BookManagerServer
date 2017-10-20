class ApplicationController < ActionController::API

  before_action :authenticate_token

  respond_to :json

  def render_ok(object)
    render json: {status: 200, result: object}, status: :ok
  end

  def render_ng
    render json: {status: 400, message: "Bad Request"}, status: :unprocessable_entity
  end

  def authenticate
    authenticate_token || failed_authentication
  end

  private
    def authenticate_token
      user = User.find_by(token: request.headers[:Authorization])
      # セッション内でユーザーを不保持 (リクエスト時に毎回tokenが必要)
      sign_in(user, store: false) if user.present?
    end

    def failed_authentication
      render json: {status: 401, message: "Unauthorized"}, status: :unauthorized
    end

end
