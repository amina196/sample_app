class UserMailer < ActionMailer::Base
	default from: "notifications@example.com"

	def welcome_email(user)
		@user = user #any instance variables we define in the method become available for use in the views.
		@url  = "tutoring.herokuapp.com"
		mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
  

  
  
  
  
  
end