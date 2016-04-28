class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
    	t.date :loan_date, null: false
    	t.string :agreement_no, null: false
    	t.references :salesrep, null: false
    	t.references :customer, null: false
    	t.decimal :loan_amount, :precision => 8, :scale => 2
    	t.string :admin_fee, :precision => 8, :scale => 2
    	t.string :total_amount, :precision => 8, :scale => 2
    	t.decimal :balance, :precision => 8, :scale => 2
    	t.integer :installments, null: false
    	t.date :final_payment_date, null: false
    	

      	t.timestamps null: false
    end

   
  end
end
