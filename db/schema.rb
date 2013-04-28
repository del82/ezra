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

ActiveRecord::Schema.define(:version => 20130409211355) do

  create_table "activities", :force => true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["owner_id", "owner_type"], :name => "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], :name => "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], :name => "index_activities_on_trackable_id_and_trackable_type"

  create_table "features", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "instructions"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "ftype"
    t.text     "fvalues"
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
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "transcript"
    t.text     "feat_vals"
    t.float    "window_start"
    t.float    "window_duration"
    t.text     "notes"
  end

  add_index "hits", ["confirmed"], :name => "index_hits_on_confirmed"
  add_index "hits", ["flagged"], :name => "index_hits_on_flagged"
  add_index "hits", ["target_id"], :name => "index_hits_on_target_id"

  create_table "statics", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "short_title"
    t.integer  "sort"
  end

  add_index "statics", ["slug"], :name => "index_statics_on_slug", :unique => true
  add_index "statics", ["sort"], :name => "index_statics_on_sort"

  create_table "stats", :force => true do |t|
    t.integer  "recent"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "availableTargets"
  end

  add_index "stats", ["user_id"], :name => "index_stats_on_user_id"

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
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "name",                   :default => "",    :null => false
    t.string   "username",               :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
