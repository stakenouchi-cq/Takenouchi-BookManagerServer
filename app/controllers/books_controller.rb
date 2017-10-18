class BooksController < ApplicationController
  include ImageHelper
  before_action :authenticate
  before_action :convert_image_to_url
  
  def create
    book = current_user.books.build(book_params)
    if book.save!
      success_book(book)
    else
      failed_request
    end
  end

  def update
    book = set_book
    if book.update_attributes(book_params)
      success_book(book)
    else
      failed_request
    end
  end

  def index
    if params[:limit].blank? || params[:page].blank?
      return # 両方のクエリパラメータが無ければ終了
    end
    limit = params[:limit].to_i
    page = params[:page].to_i

    get_books(limit, page)

  end

  private
    def set_book
      current_user.books.find(params[:id])
    end

    def book_params
      params.permit(:name, :image, :price, :purchase_date)
    end

    def convert_image_to_url
      params[:image] = upload_to_imgur(params[:image])
    end

end
