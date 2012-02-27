require 'test_helper'
require 'capybara/rails'

class UserRecordingTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  
  test "sign up a new user" do
    visit signup_path
    fill_in "Name", with: "Foo"
    click_button "Sign up"
    
    error_message = "Email can't be blank"
    assert page.has_content?(error_message)
  end
end