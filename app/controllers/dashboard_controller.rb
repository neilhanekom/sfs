class DashboardController < ApplicationController
	def index
		gon.ar = { name: 'Neil'}
	end
	
	def show
		gon.ar = { name: 'Neil'}
	end	
end	