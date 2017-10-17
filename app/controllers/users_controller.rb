class UsersController < ApplicationController
  
  def sign_up
    user = User.new(user_params)
    if user.save!
      success_user(user)
    else
      failed_request
    end
  end

  def login
    user = User.find_by(email: user_params[:email])
    # URLパラメータにあるpasswordを直接使う必要があるため、paramsにする 
    if user && user.authenticate(params[:password])
      success_user(user)
    else
      failed_request
    end
  end

  private
    def user_params
      params.permit(:email, :password)
    end

end
