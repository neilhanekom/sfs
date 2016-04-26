class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :f_name,		null: false
      t.string :l_name,		null: false
      t.string :rsaid,		null: false
      t.string :neigbour
      t.string :phone

      t.timestamps null: false
    end

    add_index :customers, :rsaid, unique: true
  end
end
