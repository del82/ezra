# -*- mode: ruby; -*-

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_targets
    make_features
    associate_features_with_targets
    make_hits
    create_activity
    create_static_pages
  end
end

def make_users n_admins=2, n_users=10
  n_admins.times do |n|
    admin = User.create!(name:     "Example admin",
                         email:    "admin-example-#{n+1}@cornell.edu",
                         username: "admin-#{n+1}",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
  end
  n_users.times do |n|
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

def make_targets n=10
  admins = User.where(admin: true)
  n.times do |u|
    admins.sample.targets.create!(phrase:  Faker::Lorem.words(2).join(' '))
  end
end

def make_feature(ftype = 0, admin = nil)
  if not admin
    admins = User.where(admin: true)
  else
    admins = [admin]
  end

  case ftype
  when 0
    fvalues = ["single", "choice", "options"]
  when 1
    fvalues = ["multiple", "options", "possible"]
  when 2
    fvalues = []
  end
    admins.sample.features.create!(name:    Faker::Lorem.words(2).join(' '),
                                   instructions: Faker::Lorem.sentence,
                                   ftype: ftype,
                                   fvalues: fvalues)
end


def make_features(n=5)
  n.times do |f|
    make_feature
  end
end

def associate_features_with_targets density=10
  features = Feature.all
  targets = Target.all

  density.times do |n|
    targets.sample.features.concat features.sample
  end
end


def pick_random_audiofile
  date = ["121409","121509","122109","122509","122909"].sample
  "audio/audio.wnyc.org/takeaway/takeaway#{date}.mp3"
end

def make_hit target=nil
  target ||= Target.all.sample

  target.hits.create!(location: (rand*10000+100).to_i.to_f / 100,
                      confirmed: [-2, -1, 0, 0, 0, 0, 1, 1].sample,
                      flagged: [false, false, false, true].sample,
                      audio_file: pick_random_audiofile,
                      transcript: Faker::Lorem.sentences(2),
                      window_start: 17.6,
                      window_duration: 10.3,
                      notes: Faker::Lorem.sentences(1)
                      )
end

def make_hits n_hits=30
  targets = Target.all
  n_hits.times do |n|
    make_hit
  end
end

def create_activity n_times=20
  hits = Hit.all
  users = User.all
  targets = Target.all
  n_times.times do |n|
    t = targets.sample
    hits.sample.create_activity(:update, owner: users.sample, recipient: t,
                                params: { phrase: t.phrase })
  end
end

def create_static_page n=0
  title = "Static Page #{n}"
  short_title = "Page #{n}"
  slug = "page#{n}"
  sort = n
  content = "
sample page #{n}
====================

A Second Level Header
---------------------

https://github.com
Now is the time for all good men to come to
the aid of their country. This is just a
regular paragraph.

The quick brown fox jumped over the lazy
dog's back.

### Header 3

> This is a blockquote.
>
> This is the second paragraph in the blockquote.
>
> ## This is an H2 in a blockquote
"
  Static.create!(title: title, short_title: short_title,
                 slug: slug, content: content, sort: sort)
end

def create_static_pages n_pages=5
  n_pages.times do |n|
    create_static_page n
  end
end
