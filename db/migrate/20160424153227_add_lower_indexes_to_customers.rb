class AddLowerIndexesToCustomers < ActiveRecord::Migration
  def up
  	execute %{
		CREATE INDEX
		customers_lower_l_name
		ON
		customers (lower(l_name) varchar_pattern_ops)
	}
	execute %{
		CREATE INDEX
		customers_lower_f_name
		ON
		customers (lower(f_name) varchar_pattern_ops)
	}
	
  end

  def down
  	remove_index :customers, name: 'customers_lower_l_name'
	remove_index :customers, name: 'customers_lower_f_name'
	
  end	
end
