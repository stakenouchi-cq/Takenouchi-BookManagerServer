class BooksController < ApplicationController
  
  def create
    book = Book.new(book_params)
    if book.save!
      success_add_book(book)
    else
      failed_request(book)
    end
  end

  private
    def book_params
      params.permit(:name, :image, :price, :purchase_date)
    end
end
