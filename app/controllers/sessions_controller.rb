class SessionsController < ApplicationController

	def new
		render 'new'
	end

	def create
		user = User.find_by(email: params[:session][:email])      #capital User is the database table
		if user && user.authenticate(params([:sessions][:password])) #remember we are handling the parameter
			sign_in user
			redirect_to user
		else
		flash.now[:error]="You have entered invalid credentials either email or password !!" #used instead of flash , as request is not send for the render page of 'new' unlike redirect_to
		render 'new'
	 end
	end

	def destroy
	end


end
