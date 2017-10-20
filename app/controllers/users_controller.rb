class UsersController < ApplicationController

  def sign_up
    user = User.new(user_params)
    if user.save
      render_ok(UserSerializer.new(user))
    else
      render_bad_request
    end
  end

  private
    def user_params
      params.permit(:email, :password)
    end

end
