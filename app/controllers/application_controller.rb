class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

	def redirect_to_dashboard
	  redirect_to dashboard_path
	end

  
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :authenticate_user!

  protected
  
	def json_request?
		request.format.json?
	end

	
end
