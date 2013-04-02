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
    ftype 0
    fvalues [true, false]
    user
  end

  factory :hit do
    location 54.6
    confirmed 0
    flagged false
    audio_file "audio/audio.wnyc.org/takeaway/takeaway121409.mp3"
    transcript { Faker::Lorem.sentences(2) }
    window_start 17.6
    window_duration 10.3
    notes "here is an example note."
    target
  end

  factory :static do
    sequence(:title) { |n| "Static page #{n}" }
    sequence(:short_title) { |n| "Static #{n}" }
    sequence(:slug) { |n| "static_#{n}" }
    sequence(:content) do
      |n| "
# Example page #{n}

Here is some *example* content.

1.  list item
2.  list item
3.  list item

Here's a [link to github](https://github.com).

And here's the end of the example content.
"
    end
  end
end
