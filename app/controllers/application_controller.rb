class ApplicationController < ActionController::Base
  protect_from_forgery

  # By default all the methods in the session helper are not available to the 
  # the controller, if we want to use it we need to add it to the app controller.
  include SessionsHelper 
end
