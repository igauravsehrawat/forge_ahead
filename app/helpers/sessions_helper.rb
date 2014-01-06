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

	def current_user?(user)
		user == current_user
	end


	def signed_in_user
	    unless signed_in?
	      store_location
	      redirect_to signin_url, notice: "Please sign in Bitch"
	    end
  	end

	def signed_in?
		!current_user.nil?
	end
	#HELPER are used to define function in every controller and view..
	#it can be called by any view and any controlller ..naming is way to distinguish the
	#and put tags for easy identification

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(user.new_remember_token))

		cookies.delete(:remember_token)  #not a hash value
		self.current_user = nil
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default )
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

end
