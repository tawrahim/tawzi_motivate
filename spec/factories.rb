# FactoryGirl allows us to create test data that can be used in RSpec, also note
# that factory girl is automatically included in RSpec so we call the user 
# varaible in our test
FactoryGirl.define do 
	factory :user do
    sequence (:name) { |n| "Person #{n}"}
    sequence (:email) { |n| "person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"

    factory :admin do
      admin true
    end
	end
end