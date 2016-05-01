class LoansController < ApplicationController
	def index

	end	

	def new
		@page = (params[:page] || 0).to_i
		if params[:keywords].present?
			@keywords = params[:keywords]
			customer_search_term = CustomerSearchTerm.new(@keywords)
			@customers = Customer.where(
				customer_search_term.where_clause,
				customer_search_term.where_args).
				order(customer_search_term.order).
				offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
		else
			@customers = []
		end

		respond_to do |format|
			format.html {}
			format.json { render json: @customers }
		end
	end	

	def create
		# puts inspect([:params])



		@loan = Loan.new(loan_params)

	    if @loan.save	
	    	respond_to do |format|
				format.json { render json: @loan }
			end 
	    else
	      # This line overrides the default rendering behavior, which
	      # would have been to render the "create" view.
	      respond_to do |format|
				format.json { render json: @loan.errors.full_messages }
			end 
	    end
	end

	private

	def loan_params
	  params.require(:loan).permit(:loan_date, :agreement_no, :salesrep_id, :customer_id, :loan_amount, :admin_fee, :total_amount, :balance, :installments, :final_payment_date)
	end
		    	
end	