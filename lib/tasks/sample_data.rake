# -*- mode: ruby; -*-

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_targets
    make_features
    make_hits
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

def make_targets
  admins = User.where(admin: true)
  10.times do |u|
    admins.sample.targets.create!(phrase:  Faker::Lorem.words(2).join(' '))
  end
end

def make_features
  admins = User.where(admin: true)
  5.times do |f|
    admins.sample.features.create!(name:    Faker::Lorem.words(2).join(' '),
                                   instructions: Faker::Lorem.sentence,
                                   ftype: 0,
                                   fvalues: [true, false])
  end
end

def make_hits
  targets = Target.all
  30.times do |f|
    targets.sample.hits.create!(location: (rand*10000+100).to_i / 100,
                                confirmed: [-2, -1, 0, 0, 0, 0, 1, 1].sample,
                                flagged: [false, false, false, true].sample,
                                audio_file: Faker::Lorem.words.join('/'),
                                transcript: Faker::Lorem.sentences(2)
                                )
  end
end
