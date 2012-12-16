# This is the sessions controller
class SessionsController < ApplicationController
	
	# New signin page and rendering the page
	def new
		
	end

	# Create a session, we would render the 'new' template if the signin fails
	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = "Invalid email/password combination"
			render 'new'
		end
	end

	# Sign out and destroy session, the sign_out method is defined in the helper
	def destroy
		sign_out
		redirect_to root_path
	end

end
