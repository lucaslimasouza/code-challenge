class ChangeCustomersName < ActiveRecord::Migration[7.1]
  def change
    rename_table :customers, :reservations
  end
end
