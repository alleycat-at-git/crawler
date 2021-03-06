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

ActiveRecord::Schema.define(version: 20140403002112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: true do |t|
    t.integer "user_profile_id"
    t.integer "friend_id"
  end

  create_table "likes", force: true do |t|
    t.integer "user_profile_id"
    t.integer "post_id"
  end

  create_table "posts", force: true do |t|
    t.integer  "vk_id",                             null: false
    t.integer  "owner_id",                          null: false
    t.text     "text"
    t.string   "attachment_type"
    t.string   "attachment_image"
    t.text     "attachment_text"
    t.string   "attachment_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attachment_id"
    t.integer  "attachment_owner_id"
    t.string   "attachment_title"
    t.integer  "date"
    t.integer  "copy_owner_id"
    t.integer  "copy_post_id"
    t.integer  "reposts_count",         default: 0
    t.integer  "comments_count",        default: 0
    t.integer  "likes_count",           default: 0
    t.integer  "likes_age"
    t.float    "likes_share"
    t.float    "closed_profiles_share"
  end

  create_table "user_profiles", force: true do |t|
    t.integer  "vk_id",                     null: false
    t.integer  "status",        default: 0
    t.integer  "friends_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthday"
  end

end
