class Payment < ActiveRecord::Base
	enum payment_status: {
	    outstanding: 	'outstanding',
	    complete:       'complete',
	    late:           'late'
	  }
end
