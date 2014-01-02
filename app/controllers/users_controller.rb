class UsersController < ApplicationController
  def new
  	@user=User.new
  end

  def show
  	@user= User.find(params[:id])
  end

#don't forget the rails architecture is built on the CRUD
#CRUD the fundamental part of the REST architecture
#either there will be create  or replace or update or delete requests
  def edit
    @user = User.find(params[:id])
  end

  def update


  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "Hey .. it's nice to know you are here ! Welcome as a new generation"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private 
  	def user_params
  		params.require(:user).permit(:name,:email,:password,:password_confirmation)
	end


end
