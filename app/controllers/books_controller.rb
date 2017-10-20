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
      render_ng
    end
  end

  def update
    if @book.update(book_params)
      render_ok(BookSerializer.new(@book))
    else
      render_ng
    end
  end

  def index
    if params[:limit].blank? || params[:page].blank?
      render_ng
    end
    limit = params[:limit].to_i
    page = params[:page].to_i
    total_count = current_user.books.count # 書籍データの総数
    @books = current_user.books.order(id: :desc).limit(limit).offset((page-1)*limit)
    render json: {
      status: 200,
      result: @books.map{|book| BookSerializer.new(book)},
      total_count: total_count,
      total_pages: (total_count / limit) + 1,
      current_page: page,
      limit: limit
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
