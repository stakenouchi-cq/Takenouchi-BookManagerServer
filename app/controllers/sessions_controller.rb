class SessionsController < ApplicationController
	before_action :authenticate, only: [:destroy]

	def create
    user = User.find_for_database_authentication(email: params[:email])
    return invalid_email unless user

    if user.valid_password?(params[:password])
      user.update_token
      sign_in(user)
      success_user(user)
    else
      failed_request
    end
  end

  def destroy
  	if user_signed_in?
      current_user.trash_token
      sign_out(current_user)
      render json: {status: 200}, status: :ok
  	end
  end

  private
    def user_params
      params.permit(:email, :password)
    end

    def invalid_email
      warden.custom_failure!
      render json: {status: 421, message: "email invalid"}, status: :misdirected_request
    end

end
