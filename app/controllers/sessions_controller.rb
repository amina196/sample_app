class SessionsController < ApplicationController

	def new
	end
	
	def create
		user = User.find_by_email(params[:session][:email]) #pulls the user out of the database using the submitted email address
		if user && user.authenticate(params[:session][:password]) #user returns true if user is in the database, authenticate comes with has_secure_password
			## Sign the user in and redirect to the user's show page or to the location he wanted to see before prompted for sign in.
			sign_in user
			redirect_back_or user
		else
			# Create an error message and re-render the signin form.
			flash.now[:error] = 'Invalid email/password combination' #.now : pour que le message d'erreur n'apparaisse qu'une seule fois
			render 'new'
		end
	end
	
	def destroy
		sign_out 
		redirect_to root_path
	end


end
