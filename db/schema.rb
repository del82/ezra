# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130216164238) do

  create_table "features", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "instructions"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "ftype"
  end

  add_index "features", ["ftype"], :name => "index_features_on_ftype"
  add_index "features", ["name"], :name => "index_features_on_name"
  add_index "features", ["user_id"], :name => "index_features_on_user_id"

  create_table "features_targets", :id => false, :force => true do |t|
    t.integer "feature_id"
    t.integer "target_id"
  end

  add_index "features_targets", ["feature_id"], :name => "index_features_targets_on_feature_id"
  add_index "features_targets", ["target_id"], :name => "index_features_targets_on_target_id"

  create_table "hits", :force => true do |t|
    t.float    "location"
    t.integer  "confirmed"
    t.boolean  "flagged"
    t.string   "audio_file"
    t.integer  "target_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "transcript"
  end

  add_index "hits", ["confirmed"], :name => "index_hits_on_confirmed"
  add_index "hits", ["flagged"], :name => "index_hits_on_flagged"
  add_index "hits", ["target_id"], :name => "index_hits_on_target_id"

  create_table "targets", :force => true do |t|
    t.string   "phrase"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "targets", ["created_at"], :name => "index_targets_on_created_at"
  add_index "targets", ["phrase"], :name => "index_targets_on_phrase"
  add_index "targets", ["user_id"], :name => "index_targets_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           :default => false
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
