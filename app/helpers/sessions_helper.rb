module SessionsHelper
	# Logs the user in by setting up a temp session.
	def log_in(user)
		session[:user_id] = user.id
	end

	# Returns the current user.
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	# Checks if a user is logged in.
	def logged_in?
		!current_user.nil?
	end

	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
end
