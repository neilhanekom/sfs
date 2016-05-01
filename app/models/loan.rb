class Loan < ActiveRecord::Base
	belongs_to :customer
	has_many :payments
end
