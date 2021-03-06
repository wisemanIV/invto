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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130818050903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attached"
  end

  create_table "clicks", force: true do |t|
    t.string   "targeturl"
    t.string   "defaulturl"
    t.string   "device"
    t.string   "browser"
    t.string   "actualurl"
    t.integer  "client_id",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "shareable_id"
    t.text     "user_agent"
  end

  create_table "client_numbers", force: true do |t|
    t.integer  "client_id"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: true do |t|
    t.string   "title"
    t.string   "contactemail"
    t.string   "defaulturl"
    t.string   "domain"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "default_android_url"
    t.text     "default_ios_url"
    t.string   "android_scheme"
    t.string   "ios_scheme"
    t.string   "mogreet_campaign_id"
  end

  create_table "community_feeds", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "email_templates", force: true do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "body"
    t.string   "from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: true do |t|
    t.string   "to"
    t.string   "from"
    t.string   "toname"
    t.string   "fromname"
    t.string   "ref"
    t.integer  "client_id",         null: false
    t.integer  "email_template_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "messages", force: true do |t|
    t.string   "to"
    t.string   "body"
    t.string   "from"
    t.string   "campaign"
    t.string   "version"
    t.string   "status",        default: "initial"
    t.integer  "user_id",                           null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "SmsId"
    t.integer  "client_id"
    t.text     "response"
    t.string   "response_code"
    t.integer  "attachment_id"
  end

  add_index "messages", ["SmsId"], name: "index_messages_on_SmsId", unique: true, using: :btree

  create_table "recipients", force: true do |t|
    t.string   "CountryCode", default: "+1"
    t.string   "Phone",                       null: false
    t.boolean  "OptOut",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "client_id"
  end

  create_table "recordings", force: true do |t|
    t.string   "tag"
    t.string   "url"
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shareables", force: true do |t|
    t.string   "shareable"
    t.integer  "client_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "campaign"
    t.string   "version"
    t.text     "destination"
    t.string   "short"
  end

  create_table "sms_archives", force: true do |t|
    t.string   "to"
    t.string   "body"
    t.string   "from"
    t.string   "campaign"
    t.string   "version"
    t.string   "status"
    t.string   "sms_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "entered_date"
    t.datetime "processed_date"
    t.integer  "client_id"
    t.integer  "user_id"
    t.text     "response"
    t.string   "response_code"
  end

  add_index "sms_archives", ["sms_id"], name: "index_sms_archives_on_sms_id", using: :btree

  create_table "sms_responses", force: true do |t|
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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "client_id"
    t.string   "attach"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.string   "authentication_token"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "client_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
