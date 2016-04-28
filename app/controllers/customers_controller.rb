class CustomersController < ApplicationController
	PAGE_SIZE = 10

	def index
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

	def show
		customer = Customer.find(params[:id]) 
		respond_to do |format|
			format.json { render json: customer } end
		end

	def new
		# respond_to do |format|
		# 	format.html {}
		# 	format.json { render json: @customers }
		# end
	end

	def create
		@customer = Customer.new(customer_params)
	    if @customer.save	
	    	respond_to do |format|
				format.json { render json: @customer }
			end 
	    else
	      # This line overrides the default rendering behavior, which
	      # would have been to render the "create" view.
	      respond_to do |format|
				format.json { render json: @customer.errors.full_messages }
			end 
	    end
	end	

	def update
	    @customer = Customer.find(params[:id])
	    if @customer.update_attributes(customer_params)
	      # Handle a successful update.
	      respond_to do |format|
				format.json { render json: @customer }
		end 
	    else
	      	
	    end
	 end

	private

	def customer_params
	  params.require(:customer).permit(:f_name, :l_name, :rsaid, :phone, :neigbour)
	end
end	