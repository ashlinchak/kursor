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

ActiveRecord::Schema.define(:version => 20120717090742) do

  create_table "address_cities", :force => true do |t|
    t.string  "name"
    t.integer "region_id"
  end

  add_index "address_cities", ["region_id"], :name => "index_address_cities_on_region_id"

  create_table "address_countries", :force => true do |t|
    t.string "name"
  end

  create_table "address_locations", :force => true do |t|
    t.integer  "city_id"
    t.string   "street"
    t.string   "building"
    t.string   "apartment"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_city"
    t.string   "custom_region"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "address_locations", ["city_id"], :name => "index_address_locations_on_city_id"

  create_table "address_regions", :force => true do |t|
    t.string "name"
  end

  create_table "administrators", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "providers_count", :default => 0
    t.string   "icon"
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "categorizings", :force => true do |t|
    t.integer  "category_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizings", ["category_id"], :name => "index_categorizings_on_category_id"
  add_index "categorizings", ["provider_id"], :name => "index_categorizings_on_provider_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contacts", :force => true do |t|
    t.integer  "contact_type_id"
    t.integer  "provider_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contactable_id"
    t.string   "contactable_type"
  end

  add_index "contacts", ["provider_id"], :name => "index_contacts_on_provider_id"

  create_table "custom_field_bindings", :force => true do |t|
    t.integer  "custom_field_id"
    t.integer  "provider_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_field_bindings", ["custom_field_id"], :name => "index_custom_field_bindings_on_custom_field_id"
  add_index "custom_field_bindings", ["provider_id"], :name => "index_custom_field_bindings_on_provider_id"

  create_table "custom_fields", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :default => 0, :null => false
  end

  create_table "custom_flag_bindings", :force => true do |t|
    t.integer  "custom_flag_id"
    t.integer  "provider_id"
    t.boolean  "value",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_flag_bindings", ["custom_flag_id"], :name => "index_custom_flag_bindings_on_custom_flag_id"
  add_index "custom_flag_bindings", ["provider_id"], :name => "index_custom_flag_bindings_on_provider_id"

  create_table "custom_flags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :default => 0, :null => false
  end

  create_table "filials", :force => true do |t|
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "filials", ["provider_id"], :name => "index_filials_on_provider_id"

  create_table "gritter_notices", :force => true do |t|
    t.integer  "owner_id",     :null => false
    t.string   "owner_type",   :null => false
    t.text     "text",         :null => false
    t.text     "options",      :null => false
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gritter_notices", ["owner_id", "delivered_at"], :name => "index_gritter_notices_on_owner_id_and_delivered_at"

  create_table "images", :force => true do |t|
    t.string   "src"
    t.string   "title"
    t.text     "description"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["imageable_id"], :name => "index_images_on_imageable_id"

  create_table "infos", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "permalink"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posting_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "permalink"
    t.boolean  "is_public",   :default => false
  end

  add_index "posting_categories", ["parent_id"], :name => "index_posting_categories_on_parent_id"

  create_table "posting_categorizings", :force => true do |t|
    t.integer  "posting_id"
    t.integer  "posting_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posting_categorizings", ["posting_category_id"], :name => "index_posting_categorizings_on_posting_category_id"
  add_index "posting_categorizings", ["posting_id"], :name => "index_posting_categorizings_on_posting_id"

  create_table "postings", :force => true do |t|
    t.string   "title"
    t.text     "excerpt"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_approved",     :default => false
    t.integer  "posting_type_id", :default => 1
  end

  add_index "postings", ["user_id"], :name => "index_postings_on_user_id"

  create_table "profiles", :force => true do |t|
    t.string   "full_name"
    t.date     "birth_date"
    t.text     "bio"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "logo"
    t.boolean  "is_approved",       :default => false
    t.text     "description_uk"
    t.text     "more_info"
    t.text     "documents_info"
    t.text     "more_info_uk"
    t.text     "documents_info_uk"
  end

  add_index "providers", ["category_id"], :name => "index_providers_on_category_id"

  create_table "ratings", :force => true do |t|
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.integer  "votes_count",   :default => 0
    t.integer  "total_value",   :default => 0
    t.float    "average_value", :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["rateable_id", "rateable_type"], :name => "index_ratings_on_rateable_id_and_rateable_type"

  create_table "schedule_events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "provider_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedule_events", ["provider_id"], :name => "index_schedule_events_on_provider_id"
  add_index "schedule_events", ["user_id"], :name => "index_schedule_events_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "students", :force => true do |t|
    t.integer  "user_id"
    t.integer  "provider_id"
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["provider_id"], :name => "index_students_on_provider_id"
  add_index "students", ["user_id"], :name => "index_students_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id"], :name => "index_taggings_on_taggable_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tutor_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.string   "permalink"
    t.integer  "tutors_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tutor_categories", ["parent_id"], :name => "index_tutor_categories_on_parent_id"

  create_table "tutor_categorizings", :force => true do |t|
    t.integer  "tutor_category_id"
    t.integer  "tutor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tutor_categorizings", ["tutor_category_id"], :name => "index_tutor_categorizings_on_tutor_category_id"
  add_index "tutor_categorizings", ["tutor_id"], :name => "index_tutor_categorizings_on_tutor_id"

  create_table "tutor_custom_field_bindings", :force => true do |t|
    t.integer  "tutor_custom_field_id"
    t.integer  "tutor_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tutor_custom_field_bindings", ["tutor_custom_field_id"], :name => "index_tutor_custom_field_bindings_on_tutor_custom_field_id"
  add_index "tutor_custom_field_bindings", ["tutor_id"], :name => "index_tutor_custom_field_bindings_on_tutor_id"

  create_table "tutor_custom_fields", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :default => 0, :null => false
  end

  create_table "tutors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "tutor_category_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_approved",       :default => false
    t.integer  "user_id"
    t.string   "avatar"
    t.text     "methodology"
    t.text     "more_info"
    t.boolean  "is_native_speaker"
  end

  add_index "tutors", ["tutor_category_id"], :name => "index_tutors_on_tutor_category_id"

  create_table "user_activations", :force => true do |t|
    t.string   "token"
    t.datetime "expire_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_activations", ["user_id"], :name => "index_user_activations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",       :default => false
    t.integer  "account_type_id", :default => 0
    t.string   "nickname"
  end

  create_table "votes", :force => true do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"

end
