class ApplicationController < ActionController::API
	
	def success_sign_up(object)
		render json: {status: 200, result: "hogefoobar"}, status: :ok
	end

	def failed_sign_up(object)
		render json: {status: 401, message: "Request Error"}, status: :unprocessable_entity
	end

end
