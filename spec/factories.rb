FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    sequence(:username) { |n| "person_#{n}" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :target do
    phrase "test target"
    user
  end

  factory :feature do
    name "test feature"
    instructions "description of test feature"
    user
  end

  factory :hit do
    location 54.6
    confirmed 0
    flagged false
    audio_file "path/to/audio.file"
    transcript { Faker::Lorem.sentences(2) }
    target
  end
end
