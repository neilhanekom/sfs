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
		format.json { render json: customer }
		end
	end

	def new
		# respond_to do |format|
		# 	format.html {}
		# 	format.json { render json: @customers }
		# end
	end

	def create
		def customer_params
		  params.permit(:f_name, :l_name, :rsaid, :phone, :neigbour)
		end
		
		@customer = Customer.new(customer_params)
	    if @customer.save
	      respond_to do |format|
		format.json { render json: customer }
		end
	    else
	      # This line overrides the default rendering behavior, which
	      # would have been to render the "create" view.
	      render "new"
	    end

	   	

	    # new_ = params[:new_post][:title][0...250] # Get only first 250 characters
	    # new_post.contents = params[:new_post][:contents]

	    # # Confirm post is valid and save or return HTTP error
	    # if new_post.valid?
	    #   new_post.save!
	    # else
	    #   render "public/422", :status => 422
	    #   return
	    # end
	end	
end	