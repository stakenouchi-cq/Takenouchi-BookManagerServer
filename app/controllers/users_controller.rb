class UsersController < ApplicationController
  
  def sign_up
    user = User.new(user_params)
    if user.save!
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
