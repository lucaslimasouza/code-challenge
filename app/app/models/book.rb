class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true 
  validates :isbn, uniqueness: true

  has_many :reservations, dependent: :destroy

  enum status: { free: 0, reserved: 1 }
end
