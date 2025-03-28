class Reservation < ApplicationRecord

  validates :email, presence: true

  belongs_to :book
end
