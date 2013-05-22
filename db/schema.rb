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

ActiveRecord::Schema.define(:version => 20130522181851) do

  create_table "geo_points", :force => true do |t|
    t.float    "lat"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "to"
    t.string   "body"
    t.string   "from"
    t.string   "ref"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "missions", :force => true do |t|
    t.string   "title"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "published"
    t.string   "contributor"
    t.string   "blurb"
    t.string   "timezone"
    t.string   "hashtag"
    t.float    "popularity"
    t.string   "photo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "startdate"
    t.datetime "enddate"
    t.float    "weather"
    t.boolean  "open"
    t.float    "weatherdep"
    t.string   "url"
  end

  create_table "opentimes", :force => true do |t|
    t.datetime "startdate"
    t.datetime "enddate"
    t.integer  "sday"
    t.integer  "eday"
    t.time     "stime"
    t.time     "etime"
    t.string   "recurrence"
    t.string   "rdetail"
    t.integer  "mission_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reports", :force => true do |t|
    t.integer  "rtype"
    t.integer  "contributor"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "schedules", :force => true do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "mission_id"
    t.integer  "opentime_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stages", :force => true do |t|
    t.string   "text"
    t.integer  "seq"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "requirescheckin"
    t.boolean  "requiresphoto"
    t.string   "hashtag"
    t.integer  "mission_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "text"
    t.integer  "tid",          :limit => 8
    t.float    "lat"
    t.float    "longitude"
    t.integer  "user_id"
    t.integer  "inresponseto", :limit => 8
    t.boolean  "responded"
    t.boolean  "hasphoto"
    t.datetime "tcreatedat"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "profile_photo_url"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "usersmissions", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "mission_id"
  end

  create_table "weathers", :force => true do |t|
    t.float    "lat"
    t.float    "long"
    t.datetime "start"
    t.datetime "end"
    t.integer  "temp"
    t.integer  "rain"
    t.integer  "humidity"
    t.integer  "cloud"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
