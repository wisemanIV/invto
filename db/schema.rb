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

ActiveRecord::Schema.define(:version => 20130714075337) do

  create_table "clicks", :force => true do |t|
    t.string   "targeturl"
    t.string   "defaulturl"
    t.string   "device"
    t.string   "browser"
    t.string   "actualurl"
    t.string   "ref"
    t.integer  "client_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "title"
    t.string   "contactemail"
    t.string   "urlscheme"
    t.string   "defaulturl"
    t.string   "domain"
    t.integer  "user_id",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "email_templates", :force => true do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "body"
    t.string   "from"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emails", :force => true do |t|
    t.string   "to"
    t.string   "from"
    t.string   "toname"
    t.string   "fromname"
    t.string   "ref"
    t.integer  "client_id",         :null => false
    t.integer  "email_template_id", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "to"
    t.string   "body"
    t.string   "from"
    t.string   "campaign"
    t.string   "version"
    t.string   "status",         :default => "initial"
    t.integer  "user_id",                               :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "SmsId"
    t.string   "TwilioResponse"
  end

  create_table "shareables", :force => true do |t|
    t.string   "input"
    t.string   "shareable"
    t.string   "ref"
    t.integer  "client_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sms_responses", :force => true do |t|
    t.string   "SMSId"
    t.string   "AccountSid"
    t.string   "From"
    t.string   "To"
    t.string   "Body"
    t.string   "FromCity"
    t.string   "FromState"
    t.string   "FromZIP"
    t.string   "FromCountry"
    t.string   "ToCity"
    t.string   "ToState"
    t.string   "ToZIP"
    t.string   "ToCountry"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
