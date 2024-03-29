#Rspec automatically loads this file and include them to our test
include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"  

  # Sign in when not using capybara to set cookies explicitly
  cookies[:remember_token] = user.remember_token
end