class RemoveColumnsFromCustomers < ActiveRecord::Migration
  def up
  		remove_column :customers, :city, :string
        remove_column :customers, :code, :string
        remove_column :customers, :address1
        remove_column :customers, :address2

  end
  
  def down
  		add_column :customers, :city, :string
        add_column :customers, :code, :string
        add_column :customers, :address1
        add_column :customers, :address2		
  end	
end

