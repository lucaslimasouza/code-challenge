require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /index" do
    it 'returns all books' do
      get api_books_path

      expect(response).to have_http_status :ok
      expect(response.body).not_to be_empty
    end
  end

  describe "GET /show" do
    it 'returns a book' do
      book = Book.create(author: "test", title: "test", isbn: "test")
      get api_books_path, params: { id: book.id}

      book_response = JSON.parse(response.body).first

      expect(response).to have_http_status :ok
      expect(book_response[:id]).not_to eq(book.id)
    end
  end

  describe "POST /reserve" do
    it 'reserves a book' do
    book = Book.create(author: "test", title: "test", isbn: "test")

    post reserve_api_book_path(book.id), params: { email: "test@example.com" }

    reserve_response = JSON.parse(response.body)

    expect(response).to have_http_status :ok
    expect(reserve_response["status"]).to eq("reserved")
    end
  end
end
