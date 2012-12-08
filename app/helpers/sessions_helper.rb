# This is the module that contains all the helper methods for our sessions views
module SessionsHelper

	# This method signs the user in to our application
	# Our application automatically remembers the user unless they sign out
	# To do this we are going to use a permananent cookie which expires in 20years
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	# The signed_in method would be true if the current user is not nil
	# Remember that a current user that is nil means the have not signed in
	def signed_in?
		!current_user.nil?
	end	

	# This is the settor for the user, this captures the user in the
	# current user variable
	def current_user=(user)
		@current_user = user
	end

	# This is the getter method for pulling the user out with its remember token
	# The first time when we access current user it would be nil which means that
	# we need to get the user from the database, subsequently it is not going
	# to be nil but we would have already stored it in a variable
	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end	

	# Signout method
	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end	

end
