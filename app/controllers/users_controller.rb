class UsersController < ApplicationController
  def new
  @user = User.new
  end
  
  def show
	@user = User.find(params[:id])
  end
  
  def create
	@user = User.new(params[:user]) #params[:user] = hash with all the values of all the attributes of the user model ! => create a user out of the hash
    if @user.save
		flash[:success] = "Welcome to the sample app ! "
		redirect_to @user
    else
      render 'new'
    end
  end

end
