puts "Creating sample books..."

# Create sample books
20.times do |i|
  Book.create(
    title: "Book #{i+1}",
    author: "Author #{(i % 5) + 1}",
    isbn: "ISBN-#{rand(1000000..9999999)}",
  )
end

# Create books with different statuses
Book.create(title: "Reserved Book", author: "Test Author", isbn: "ISBN-RESERVED")
Book.create(title: "Checked Out Book", author: "Test Author", isbn: "ISBN-CHECKED")

puts "Seed data created successfully!"
