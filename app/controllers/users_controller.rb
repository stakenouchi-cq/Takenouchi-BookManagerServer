class UsersController < ApplicationController
  def sign_up
    user = User.new(user_params)
    if user.save!
      success_sign_up(user)
    else
      failed_sign_up(user)
    end
  end

  private
    def user_params
      params.permit(:email, :password)
    end
end
