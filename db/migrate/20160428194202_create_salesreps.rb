class CreateSalesreps < ActiveRecord::Migration
  def change
    create_table :salesreps do |t|
    	t.string :f_name, null: false
    	t.string :l_name, null: false
    end
  end
end
