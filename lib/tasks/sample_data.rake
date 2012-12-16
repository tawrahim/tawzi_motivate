namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!( name: "Example User",
                  email: "example@taw.com",
                  password: "foobar",
                  password_confirmation: "foobar" )
    admin.toggle!(:admin)
    99.times do |n|
      # Here we are using the faker GEM to create dummy data for our db
      name = Faker::Name.name
      email = "example-#{n+1}@taw.com"
      password = "password"
      User.create!(name:name, email: email, password: password, 
                  password_confirmation: password)
    end
  end
end