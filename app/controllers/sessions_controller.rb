class SessionsController < ApplicationController

	def new
		render 'new'
	end

	def create
		user = User.find_by(email: params[:session][:email])      #capital User is the database table
		if user && user.authenticate(params[:session][:password]) #remember we are handling the parameter #it's not sessionS just session
			sign_in user
			redirect_back_or user #see it has been changed for friendly forwarding
		else
		flash.now[:error]="You have entered invalid credentials either email or password !!" #used instead of flash , as request is not send for the render page of 'new' unlike redirect_to
		render 'new'
	 end
	end

	def destroy
		sign_out
		redirect_to root_url #could be root path
	end


end
