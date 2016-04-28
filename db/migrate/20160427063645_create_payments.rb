class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.references :customer, null: false
    	t.references :loan, null: false
    	t.string :receipt_no, null: false
    	t.date :date_paid, null: false
    	t.date :date_due, null: false
    	t.decimal :amount_due, :precision => 8, :scale => 2
    	t.decimal :amount_paid, :precision => 8, :scale => 2
    
      	t.timestamps null: false
    end
  end
end
