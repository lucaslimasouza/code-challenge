require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # Test setup: Create a valid book for reuse in tests
  def setup
    @book = Book.new(
      title: "Sample Book",
      author: "Sample Author",
      isbn: "1234567890"
    )
  end

  # Test that a book with valid attributes can be saved
  test "should save valid book" do
    assert @book.save, "Could not save the book with valid attributes"
  end

  # Test that a book without a title is invalid
  test "should not save book without title" do
    @book.title = nil
    assert_not @book.save, "Saved the book without a title"
  end

  # Test that a book without an author is invalid
  test "should not save book without author" do
    @book.author = nil
    assert_not @book.save, "Saved the book without an author"
  end

  # Test that a book with a duplicate ISBN is invalid
  test "should not save book with duplicate ISBN" do
    @book.save
    duplicate_book = Book.new(
      title: "Another Book",
      author: "Another Author",
      isbn: @book.isbn
    )
    assert_not duplicate_book.save, "Saved the book with a duplicate ISBN"
  end
end
