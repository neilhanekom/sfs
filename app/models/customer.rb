class Customer < ActiveRecord::Base
	has_one :address
	has_many :loans
	has_many :payments
end
