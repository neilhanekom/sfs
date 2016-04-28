class AddStatusToPayments < ActiveRecord::Migration

	def up
		execute <<-SQL
			CREATE TYPE payment_status AS ENUM ('outstanding', 'complete', 'late');
		SQL

		 add_column :payments, :payment_status, :payment_status, index: true
	end

	def down
		remove_column :payments, :payment_status

		execute <<-SQL
			DROP TYPE payment_status;
		SQL
	end
  
end
