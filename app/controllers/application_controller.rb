class ApplicationController < ActionController::API

  before_action :authenticate_token

  respond_to :json

  def success_user(user)
    render json: {status: 200, result: UserSerializer.new(user)}, status: :ok
  end

  def success_book(book)
    render json: {status: 200, result: BookSerializer.new(book)}, status: :ok
  end

  def get_books(limit, page)
    total_count = current_user.books.count # 書籍データの総数
    books = current_user.books.select('id, name, image, price, purchase_date').order(id: :desc).limit(limit).offset((page-1)*limit)
    render json: {
      status: 200,
      result: books,
      total_count: total_count,
      total_pages: (total_count/limit) + 1,
      current_page: page,
      limit: limit
    }, status: :ok
  end

  def failed_request
    render json: {status: 400, message: "Bad Request"}, status: :unprocessable_entity
  end

  def authenticate
    authenticate_token || failed_authentication
  end

  private
    def authenticate_token
      user = User.find_by(token: request.headers[:Authorization])
      # セッション内でユーザーを不保持 (リクエスト時に毎回tokenが必要)
      sign_in(user, store: false) if user.present?
    end

    def failed_authentication
      render json: {status: 401, message: "Unauthorized"}, status: :unauthorized
    end

end
