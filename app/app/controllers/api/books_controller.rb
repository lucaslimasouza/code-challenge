module Api
  class BooksController < ApplicationController
    def index
      @books = Book.all
      render json: @books
    end
    
    def show
      @book = Book.find(params[:id])
      render json: @book
    end
    
    # TODO: Implement reserve endpoint
    def reserve
      book = Book.find(book_params[:id])
      return render json: book, status: :unprocessable_entity if book.reserved?
      
      book.reservations.create(email: book_params[:email])
      book.update(status: :reserved)
      
      render json: book.reload
    end
  
    def book_params
      params.permit(:email, :id)
    end
  end
end
