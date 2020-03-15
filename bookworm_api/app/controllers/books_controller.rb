class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /api/v1/books
  def index
    @books = Book.all

    render json: @books, each_serializer: BookSerializer
  end

  # GET /api/v1/books/1
  def show
    render json: @book, serializer: BookWithAvailableCopiesSerializer
  end

  # POST /api/v1/books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, serializer: BookWithAvailableCopiesSerializer
    else
      render json: {errors: @book.errors}, status: 400
    end
  end

  # PATCH/PUT /api/v1/books/1
  def update
    if @book.update(params.require(:book).permit(:quantity))
      render json: @book, serializer: BookWithAvailableCopiesSerializer
    else
      render json: {errors: @book.errors}, status: 400
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:isbn, :title, :author, :published_on, :quantity, :fee)
    end
end
