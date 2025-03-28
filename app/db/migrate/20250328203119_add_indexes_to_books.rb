class AddIndexesToBooks < ActiveRecord::Migration[7.1]
  def change
    add_index :books, [:title, :author, :status]
  end
end
