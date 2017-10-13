class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Token::ControllerMethods

	def success_sign_up(user)
		render json: {status: 200, result: UserSerializer.new(user)}, status: :ok
	end

	def success_login(user)
		render json: {status: 200, result: UserSerializer.new(user)}, status: :ok
	end

	def success_add_book(book)
		render json: {status: 200, result: BookSerializer.new(book)}, status: :ok
	end

	def failed_request()
		render json: {status: 401, message: "Request Error"}, status: :unprocessable_entity
	end

	def failed_authentication()
		render json: {status: 401, message: "Authentication Error"}, status: :unprocessable_entity
	end

	def require_login!
		return true if authenticate_token
		failed_authentication()
	end

	def current_user
		@_current_user ||= authenticate_token
	end

	private 
		def authenticate_token
			authenticate_with_http_token do |token, options|
				User.find_by(token: token)
			end
		end

end
