# FactoryGirl allows us to create test data that can be used in RSpec, also note
# that factory girl is automatically included in RSpec so we call the user 
# varaible in our test
FactoryGirl.define do 
	factory :user do
		name "Tawheed Raheem"
		email "tawrahim@gmail.com"
		password "foobar"
		password_confirmation "foobar"
	end
end