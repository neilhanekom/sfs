class AddForeignKeyToLoans < ActiveRecord::Migration
  def change
  	add_foreign_key :loans, :customers
  end
end
