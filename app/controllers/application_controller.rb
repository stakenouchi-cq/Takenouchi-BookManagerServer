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

	def success_edit_book(book)
		render json: {status: 200, result: BookSerializer.new(book)}, status: :ok
	end

	def get_books(limit, page)
		books = Book.select('id, name, image, price, purchase_date').order(id: :desc).limit(limit).offset((page-1)*limit)
		render json: {status: 200, result: books}, status: :ok
	end

	def failed_request()
		render json: {status: 401, message: "Request Error"}, status: :unprocessable_entity
	end

	def authenticate
		authenticate_token || failed_authentication
	end

	private
		def authenticate_token
			user = User.find_by(token: request.headers['Authorization'])
		end

		def failed_authentication
			render json: {status: 401, message: "Authentication Error"}, status: :unprocessable_entity
		end

end
