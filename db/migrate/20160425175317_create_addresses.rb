class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.string :addressline1, null: false
    	t.string :addressline2
    	t.string :suburb, null: false
    	t.string :town, null: false
    	t.string :city, null: false
    	t.string :province, null: false
    	t.string :postcode, null: false


      t.timestamps null: false
    end
  end
end
