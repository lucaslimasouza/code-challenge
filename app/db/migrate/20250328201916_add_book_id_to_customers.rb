class AddBookIdToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_reference :customers, :book, index: true
  end
end
