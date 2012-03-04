class UsersController < ApplicationController
  #to prevent access to edit/update actions of any user if the click doesn't come from a signed-in user
  before_filter :signed_in_user, only: [:index,:edit, :show, :update]
  before_filter :correct_user, only: [:edit, :show, :update]
  before_filter :admin_user, only: :destroy
  
  def index
	  @users = User.paginate(page: params[:page])
  end
  
  def new
	@user = User.new
  end
  
  def create
	@user = User.new(params[:user]) #params[:user] visible dans le corps de la requete HTTP = hash with all the values of all the attributes of the user model ! => create a user out of the hash
    if @user.save
		sign_in @user
		flash[:success] = "Welcome to the sample app ! "
		redirect_to @user  #it tells the browser to send a new request for a different URL, the newly created user’s profile
    else
      render 'new'
    end
  end
  
  def edit
		# No need to define @user = User.find(params[:id]) since it is gonna be created in the correct_user helper
	
  end
  
  def update
	@user = User.find(params[:id]) #cf get request in the server log : we send the id of the current user
	if @user.update_attributes(params[:user])#cf put request in the server log : when we fill in the form, we send a hash named user, that has name, email, password, password_confirmation
		flash[:success] = "Your personal information has been updated. "
		sign_in @user
		redirect_back_or @user
	else
		render 'edit' 
	end
  end
  
  def show
	@user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  
  private
	def signed_in_user
		unless signed_in? # if !signed_in?
			store_location
			flash[:notice] = "Please sign in to access this page."
			redirect_to signin_path
		end
	end
	
	def correct_user
		@user = User.find(params[:id])
		unless current_user.id == @user.id #trying to access a page that does not belong to me ! 
			flash[:notice] = "You need to be signed in as this user to update their contents."
			redirect_to root_path
		end
	end
	
	def admin_user
		redirect_to(root_path) unless current_user.admin? #if current user is not admin, redirect to root path
	end
end
