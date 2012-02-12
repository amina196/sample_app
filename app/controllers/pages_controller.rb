class PagesController < ApplicationController
  def home
	@title = "Home"
  end

  def contact
	@title = "Contact"
  end
  
  def about
	@title = "About"
  end
  
  def help
	@title = "Help"
  end
  
  def signup
	@title = "Sign up !"
  end

  def signin
	@title = "Sign in !"
  end

end
