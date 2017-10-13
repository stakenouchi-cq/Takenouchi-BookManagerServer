class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update]
  
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

  private
    def set_book
      book = Book.find(params[:id])
    end

    def book_params
      params.permit(:name, :image, :price, :purchase_date)
    end

end
