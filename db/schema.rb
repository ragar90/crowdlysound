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

ActiveRecord::Schema.define(version: 20131019071827) do

  create_table "agrupations", force: true do |t|
    t.integer  "member_id"
    t.integer  "band_id"
    t.boolean  "is_leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bands", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "casting_settings", force: true do |t|
    t.integer  "song_id"
    t.integer  "filter_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "castings", force: true do |t|
    t.integer  "caster_id"
    t.integer  "casting_song_id"
    t.integer  "status",          default: 3
    t.integer  "instrument_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "message"
    t.integer  "author_id"
    t.string   "comentable_id"
    t.string   "comentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cowriters", force: true do |t|
    t.integer  "coauthor_id"
    t.integer  "coauthored_song_id"
    t.integer  "casting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filter_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genre_tags", force: true do |t|
    t.integer  "genre_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instrument_skills", force: true do |t|
    t.integer  "musician_id"
    t.integer  "instrument_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instrument_tags", force: true do |t|
    t.integer  "instrument_id"
    t.integer  "song_id"
    t.boolean  "written_by_me"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "music_sheets", force: true do |t|
    t.text     "notes"
    t.integer  "song_id"
    t.integer  "instrument_id"
    t.integer  "rock_likes_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "music_tastes", force: true do |t|
    t.integer  "musician_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "musicians", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "cover_of_id"
    t.integer  "rock_likes_count"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
