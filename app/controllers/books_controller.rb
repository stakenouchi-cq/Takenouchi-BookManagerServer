class BooksController < ApplicationController
  include ImageHelper
  before_action :authenticate
  before_action :set_book, only: [:update]
  before_action :convert_image_to_url, only: [:create, :update]

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      render_ok(BookSerializer.new(@book))
    else
      render_bad_request
    end
  end

  def update
    if @book.update(book_params)
      render_ok(BookSerializer.new(@book))
    else
      render_bad_request
    end
  end

  def index
    limit = params[:limit].presence || 20
    page = params[:page].presence || 1
    @books = current_user.books.order(id: :desc).page(page).per(limit)
    
    render json: {
      status: 200,
      result: @books.map{|book| BookSerializer.new(book)},
      total_count: @books.total_count,
      total_pages: @books.total_pages,
      current_page: @books.total_count,
      limit: @books.limit_value
    }, status: :ok

  end

  private
    def set_book
      @book = current_user.books.find(params[:id])
    end

    def book_params
      params.permit(:name, :image, :price, :purchase_date)
    end

    def convert_image_to_url
      params[:image] = upload_to_imgur(params[:image])
    end

end
