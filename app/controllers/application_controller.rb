class ApplicationController < ActionController::API
	
	def success_sign_up(user)
		render json: {status: 200, result: UserSerializer.new(user)}, status: :ok
	end

	def success_login(user)
		render json: {status: 200, result: UserSerializer.new(user)}, status: :ok
	end

	def failed_request(user)
		render json: {status: 401, message: "Request Error"}, status: :unprocessable_entity
	end

end
