require 'spec_helper'

# This is the test for the user
describe User do
  
  # We define a user and make it the subject of our test
  before do
  		 @user = User.new(name: "Example User", email: "user@example.com",
  							password: "foobar", password_confirmation: "foobar" )
  end
  
  subject { @user }

  # These are the attributes of our user's table
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) } 

  # Makes sure that the name and email field is vaild
  it {should be_valid}

  describe "when name is not present" do
  	before { @user.name = " "}
  	it { should_not be_valid }
  end

  # This block of test makes sure that the email field is not empty
  describe "when email is not present" do
  	before { @user.email = " "}
  	it { should_not be_valid }
  end

  # This test to make sure name is not longer than 51
  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  # This checks to see whether email is valid or not
  # It loops over what we provided to match the pattern
  describe "when email format is not valid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			@user.should_not be_valid
  		end
  	end
  end
 
  # This is when the email is valid
  describe "when email format is valid " do
  	it "should be valid" do
	  	addresses = %w[user@foo.COM A_US-er@f.b.org first.lst@foo.jp a+b@baz.cn]
	  	addresses.each do |valid_address|
	  			@user.email = valid_address
	  			@user.should be_valid
	  		end
	  	end
  end

  # Test to check whether email address is taken
  describe "When email is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end
  	it { should_not be_valid }
  end   

  # Test to see whether password is not present 
  describe "when password is not present" do
  	before { @user.password = @user.password_confirmation = " "}
  	it { should_not be_valid }
  end

  # Test for password confirmation mistmatch
  describe "when password does not match confirmation" do
  	before { @user.password_confirmation = "mismatch"}
  	it { should_not be_valid }
  end

  # Test to see if confirmation is nil
  describe "when password confirmation is nil" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  # Test for password length
  describe "when password is too short" do
  		before { @user.password = @user.password_confirmation = "a" * 5 }
  		it { should_not be_valid }
  end

  
  describe "return value of authenticate method" do
  		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email)}  

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password)}
		end	

		describe "with invalid password" do
			let(:user_for_invalid_password) {found_user.authenticate("invalid")}
			it { should_not == user_for_invalid_password}
			specify { user_for_invalid_password.should be_false}
		end
  end

    describe "remeber token" do
      before { @user.save }
      its(:remember_token) { should_not be_blank }
  end 
end
