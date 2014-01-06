class UsersController < ApplicationController
#before filter
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
   @users = User.paginate(page: params[:page])
  end

  def new
  	@user=User.new
  end

  def show
  	@user= User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page] )
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end

#don't forget the rails architecture is built on the CRUD
#CRUD the fundamental part of the REST architecture
#either there will be create  or replace or update or delete requests
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user

    else
      render 'edit' #back there 
    end
  end



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

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in Bitch"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) #dont know what this is used
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  

end
