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

ActiveRecord::Schema.define(version: 20150819014658) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cats", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "sex"
    t.integer  "age"
    t.date     "date_trapped"
    t.boolean  "altered"
    t.boolean  "eartipped"
    t.string   "rabies_tag"
    t.string   "distemper"
    t.string   "microchip"
    t.string   "photo"
    t.integer  "colony_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "cats", ["colony_id"], name: "index_cats_on_colony_id", unique: true, using: :btree

  create_table "colonies", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "photo"
    t.string   "street_address", null: false
    t.string   "city",           null: false
    t.string   "state",          null: false
    t.string   "zip_code"
    t.string   "enviroment"
    t.integer  "pop"
    t.string   "vet"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "colony_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "colony_id"
    t.boolean  "owner"
    t.boolean  "volunteer"
    t.boolean  "care_taker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "colony_users", ["user_id", "colony_id"], name: "index_colony_users_on_user_id_and_colony_id", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "organization_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_users", ["user_id", "organization_id"], name: "index_organization_users_on_user_id_and_organization_id", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",           null: false
    t.text     "description"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "thredded_categories", force: :cascade do |t|
    t.integer  "messageboard_id", null: false
    t.string   "name",            null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",            null: false
  end

  add_index "thredded_categories", ["messageboard_id", "slug"], name: "index_thredded_categories_on_messageboard_id_and_slug", unique: true, using: :btree
  add_index "thredded_categories", ["messageboard_id"], name: "index_thredded_categories_on_messageboard_id", using: :btree

  create_table "thredded_images", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "width"
    t.integer  "height"
    t.string   "orientation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_images", ["post_id"], name: "index_thredded_images_on_post_id", using: :btree

  create_table "thredded_messageboards", force: :cascade do |t|
    t.string   "name",                                       null: false
    t.string   "slug"
    t.text     "description"
    t.string   "security",             default: "public"
    t.string   "posting_permission",   default: "anonymous"
    t.integer  "topics_count",         default: 0
    t.integer  "posts_count",          default: 0
    t.boolean  "closed",               default: false,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filter",               default: "markdown",  null: false
    t.integer  "private_topics_count", default: 0
  end

  add_index "thredded_messageboards", ["closed"], name: "index_thredded_messageboards_on_closed", using: :btree
  add_index "thredded_messageboards", ["slug"], name: "index_thredded_messageboards_on_slug", using: :btree

  create_table "thredded_notification_preferences", force: :cascade do |t|
    t.boolean  "notify_on_mention", default: true
    t.boolean  "notify_on_message", default: true
    t.integer  "user_id",                          null: false
    t.integer  "messageboard_id",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_notification_preferences", ["messageboard_id"], name: "index_thredded_notification_preferences_on_messageboard_id", using: :btree
  add_index "thredded_notification_preferences", ["user_id"], name: "index_thredded_notification_preferences_on_user_id", using: :btree

  create_table "thredded_post_notifications", force: :cascade do |t|
    t.string   "email",      null: false
    t.integer  "post_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_post_notifications", ["post_id"], name: "index_thredded_post_notifications_on_post_id", using: :btree

  create_table "thredded_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.string   "ip"
    t.string   "filter",          default: "markdown"
    t.string   "source",          default: "web"
    t.integer  "postable_id"
    t.integer  "messageboard_id",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "postable_type"
  end

  add_index "thredded_posts", ["messageboard_id"], name: "index_thredded_posts_on_messageboard_id", using: :btree
  add_index "thredded_posts", ["postable_id", "postable_type"], name: "index_thredded_posts_on_postable_id_and_postable_type", using: :btree
  add_index "thredded_posts", ["postable_id"], name: "index_thredded_posts_on_postable_id", using: :btree
  add_index "thredded_posts", ["user_id"], name: "index_thredded_posts_on_user_id", using: :btree

  create_table "thredded_private_topics", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "last_user_id",                null: false
    t.string   "title",                       null: false
    t.string   "slug",                        null: false
    t.integer  "messageboard_id",             null: false
    t.integer  "posts_count",     default: 0
    t.string   "hash_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_private_topics", ["hash_id"], name: "index_thredded_private_topics_on_hash_id", using: :btree
  add_index "thredded_private_topics", ["messageboard_id"], name: "index_thredded_private_topics_on_messageboard_id", using: :btree
  add_index "thredded_private_topics", ["slug"], name: "index_thredded_private_topics_on_slug", using: :btree

  create_table "thredded_private_users", force: :cascade do |t|
    t.integer  "private_topic_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read",             default: false
  end

  add_index "thredded_private_users", ["private_topic_id"], name: "index_thredded_private_users_on_private_topic_id", using: :btree
  add_index "thredded_private_users", ["read"], name: "index_thredded_private_users_on_read", using: :btree
  add_index "thredded_private_users", ["user_id"], name: "index_thredded_private_users_on_user_id", using: :btree

  create_table "thredded_roles", force: :cascade do |t|
    t.string   "level"
    t.integer  "user_id"
    t.integer  "messageboard_id"
    t.datetime "last_seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_roles", ["messageboard_id"], name: "index_thredded_roles_on_messageboard_id", using: :btree
  add_index "thredded_roles", ["user_id"], name: "index_thredded_roles_on_user_id", using: :btree

  create_table "thredded_topic_categories", force: :cascade do |t|
    t.integer "topic_id",    null: false
    t.integer "category_id", null: false
  end

  add_index "thredded_topic_categories", ["category_id"], name: "index_thredded_topic_categories_on_category_id", using: :btree
  add_index "thredded_topic_categories", ["topic_id"], name: "index_thredded_topic_categories_on_topic_id", using: :btree

  create_table "thredded_topics", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.integer  "last_user_id",                    null: false
    t.string   "title",                           null: false
    t.string   "slug",                            null: false
    t.integer  "messageboard_id",                 null: false
    t.integer  "posts_count",     default: 0,     null: false
    t.boolean  "sticky",          default: false, null: false
    t.boolean  "locked",          default: false, null: false
    t.string   "hash_id",                         null: false
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_topics", ["hash_id"], name: "index_thredded_topics_on_hash_id", using: :btree
  add_index "thredded_topics", ["messageboard_id", "slug"], name: "index_thredded_topics_on_messageboard_id_and_slug", unique: true, using: :btree
  add_index "thredded_topics", ["messageboard_id"], name: "index_thredded_topics_on_messageboard_id", using: :btree
  add_index "thredded_topics", ["user_id"], name: "index_thredded_topics_on_user_id", using: :btree

  create_table "thredded_user_details", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.datetime "latest_activity_at"
    t.integer  "posts_count",        default: 0
    t.integer  "topics_count",       default: 0
    t.boolean  "superadmin",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_user_details", ["latest_activity_at"], name: "index_thredded_user_details_on_latest_activity_at", using: :btree
  add_index "thredded_user_details", ["user_id"], name: "index_thredded_user_details_on_user_id", using: :btree

  create_table "thredded_user_preferences", force: :cascade do |t|
    t.integer  "user_id",                                           null: false
    t.string   "time_zone",  default: "Eastern Time (US & Canada)"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_user_preferences", ["user_id"], name: "index_thredded_user_preferences_on_user_id", using: :btree

  create_table "thredded_user_topic_reads", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "topic_id",                null: false
    t.integer  "post_id",                 null: false
    t.integer  "posts_count", default: 0, null: false
    t.integer  "page",        default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_user_topic_reads", ["topic_id"], name: "index_thredded_user_topic_reads_on_topic_id", using: :btree
  add_index "thredded_user_topic_reads", ["user_id", "topic_id"], name: "index_thredded_user_topic_reads_on_user_id_and_topic_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "display_name",                        null: false
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.integer  "age"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["display_name"], name: "index_users_on_display_name", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
