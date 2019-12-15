# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_191_215_121_733) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'feed_posts', force: :cascade do |t|
    t.bigint 'feed_id'
    t.time 'published_at'
    t.string 'link'
    t.text 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['feed_id'], name: 'index_feed_posts_on_feed_id'
    t.index ['published_at'], name: 'index_feed_posts_on_published_at'
  end

  create_table 'feeds', force: :cascade do |t|
    t.string 'url', null: false
    t.string 'channel_title'
    t.integer 'state', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['url'], name: 'index_feeds_on_url'
  end

  create_table 'user_feeds', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'feed_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['feed_id'], name: 'index_user_feeds_on_feed_id'
    t.index ['user_id'], name: 'index_user_feeds_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end
end
