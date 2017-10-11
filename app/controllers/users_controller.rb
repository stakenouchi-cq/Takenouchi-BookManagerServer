class UsersController < ApplicationController

  def sign_up
    user = User.new(user_params)
    if user.save
      success_sign_up(user)
    else
      failed_sign_up(user)
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:email, :password)
    end

end
