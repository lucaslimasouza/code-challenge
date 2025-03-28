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
    # def reserve
    # end
  end
end
