require 'test_helper'
 
class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  test "should not save user without name or email" do
	user = User.new
	assert !user.save
  end
  
  test "email matches regular expression" do
	user = User.create(name:"Amina", email:"amina@gmail.com", password:"foobar", password_confirmation:"foobar")
	assert_match( "/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i", user.email, "Email has wrong regular expression" )
  end

  
end