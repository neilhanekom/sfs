# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Customer.all.count == 0
	10_000.times do |i|
		Customer.create!(
			f_name: Faker::Name.first_name,
				l_name: Faker::Name.last_name,
					rsaid: Faker::Number.number(13).to_s,
						neigbour: Faker::Name.name,
							 phone: Faker::Number.between(0, 0).to_s + Faker::Number.between(7, 8).to_s + Faker::Number.between(1, 9).to_s + Faker::Number.number(7).to_s
		)	
	end
end



# Helper method to create a billing address for a customer
def create_address(customer_id)
	# billing_state = State.all[rand(num_states)]
	new_address = Address.create!(
		customer_id: customer_id,
		addressline1: Faker::Address.secondary_address,
		addressline2: Faker::Address.street_address,
		suburb: Faker::Address.street_name,
		city: Faker::Address.city,
		town: Faker::Address.city,
		province: Faker::Address.state, 
		postcode: Faker::Address.postcode 

	)

end

# Cache the number of states so we don't have to query
# ecah time through
	
	# For all customers
	Customer.all.pluck(:id).each do |customer_id|
		create_address(customer_id)
		# Create a billing address for them
		#create_billing_address(customer_id,num_states)
		# Create a random number of shipping addresses, making
		# sure we create at least 1
		#num_shipping_addresses = rand(4) + 1
		#num_shipping_addresses.times do |i|
		# Create the shipping address, setting the first one
		# we create as the "primary"
		#create_shipping_address(customer_id,num_states,i == 0)

		
	end	
