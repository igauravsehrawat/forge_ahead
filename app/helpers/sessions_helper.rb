module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user 
		#self.current will not be used here because we have used the redirect_to call
		#instead it will be used where redirect  is not needed
	end

	def current_user=(user)
		@current_user=user
	end

	def current_user

		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
			# ||= sees if previously current_user has been assigned any value or not
			#if not assigned if will then hit the database
	end

	def signed_in?
		!current_user.nil?
	end


end
