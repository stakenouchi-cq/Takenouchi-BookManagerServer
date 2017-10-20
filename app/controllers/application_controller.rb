class ApplicationController < ActionController::API

  before_action :authenticate_from_token

  respond_to :json

  def render_ok(object)
    render json: {status: 200, result: object}, status: :ok
  end

  def render_bad_request
    render json: {status: 400, message: "Bad Request"}, status: :bad_request
  end

  private
    def authenticate_from_token
      user = User.find_by(token: request.headers[:Authorization])
      # セッション内でユーザーを不保持 (リクエスト時に毎回tokenが必要)
      sign_in(user, store: false) if user.present?
    end

    def render_unauthorized
      render json: {status: 401, message: "Unauthorized"}, status: :unauthorized
    end
end
