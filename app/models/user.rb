# This is the User model file which takes care of our user table
class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  
  # The has_secured_password provides us with the authenticate
  # attribute
  has_secure_password

  # Before save callback method, this code would be executed
  # before the active record object gets saved
  before_save  { |user| user.email = user.email.downcase }
  before_save :create_remember_token

  # Makes sure that the user supplies email and name
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+@\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true					

  private
    # This is a method to set the user's remember token using rail's base64
    # The token gives us a unique string for each user
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
end
