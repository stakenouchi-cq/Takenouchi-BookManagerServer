class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Token::ControllerMethods

	def success_user(user)
		render json: {status: 200, result: UserSerializer.new(user)}, status: :ok
	end

	def success_book(book)
		render json: {status: 200, result: BookSerializer.new(book)}, status: :ok
	end

	def get_books(limit, page)
		books = @current_user.books.select('id, name, image, price, purchase_date').order(id: :desc).limit(limit).offset((page-1)*limit)
		render json: {status: 200, result: books}, status: :ok
	end

	def failed_request
		render json: {status: 400, message: "Bad Request"}, status: :unprocessable_entity
	end

	def authenticate
		authenticate_token || failed_authentication
	end

	private
		def authenticate_token
			@current_user = User.find_by(token: request.headers[:Authorization])
		end

		def failed_authentication
			render json: {status: 401, message: "Unauthorized"}, status: :unauthorized
		end

end
