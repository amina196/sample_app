module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		current_user = user
	end
	
	def sign_out
		cookies.delete(:remember_token)
	end
	
	#designed to handle assignment to current_user variable, called by code like "current_user = blaa"
	def current_user= (user)  
		@current_user = user  
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def current_user
		@current_user ||= user_from_remembered_token
		#calls the user_from_remember_token method the first time current_user is called, 
		#but on subsequent invocations returns @current_user without calling user_from_remember_token.7
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default) #evaluates to session[:return_to] unless it is nil 
		clear_return_to
	end

	def store_location
	#puts the requested URI in the session variable under the key :return_to
		session[:return_to] = request.fullpath #the full path (URI) of the requested page
	end
  
	private
	def user_from_remembered_token
		remembered_token = cookies[:remember_token]
		User.find_by_remember_token(remembered_token) unless remembered_token.nil?
	end
end
