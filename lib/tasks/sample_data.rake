namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@cornell.edu",
                       username: "example",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  10.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@cornell.edu"
    username = "example-#{n+1}"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 username: username,
                 password: password,
                 password_confirmation: password)
  end
end
