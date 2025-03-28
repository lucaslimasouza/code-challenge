class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true 
  validates :isbn, uniqueness: true
end
