FactoryGirl.define do
  factory :user do
    name     "David Lutz"
    email    "del82@cornell.edu"
    username "del82"
    password "foobar"
    password_confirmation "foobar"
  end
end
