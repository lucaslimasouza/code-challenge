class ChangeBooksColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :books, :status, :integer, default: 0
  end
end
