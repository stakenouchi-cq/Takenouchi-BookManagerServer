class BooksController < ApplicationController
  before_action :authenticate, only: [:create, :update, :show, :index]
  
  def create
    book = Book.new(book_params)
    if book.save!
      success_add_book(book)
    else
      failed_request()
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(params[:book])
      success_edit_book(book)
    else
      failed_request()
    end
  end

  def index
    if params[:limit].blank? || params[:page].blank?
      return # 両方のクエリパラメータを含む必要あり  
    end
    limit = params[:limit].to_i
    page = params[:page].to_i

    get_books(limit, page)

  end

  private
    def set_book
      book = Book.find(params[:id])
    end

    def book_params
      params.permit(:name, :image, :price, :purchase_date)
    end

end
