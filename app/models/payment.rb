class Payment < ActiveRecord::Base
	enum payment_status: {
	    outstanding: 	'outstanding',
	    complete:       'complete',
	    late:           'late'
	  }

	belongs_to :customer
	belongs_to :loan  
end
