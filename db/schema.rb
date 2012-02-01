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

ActiveRecord::Schema.define(:version => 20120201194444) do

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

  create_table "postings", :force => true do |t|
    t.string   "title"
    t.text     "excerpt"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "postings", ["user_id"], :name => "index_postings_on_user_id"

  create_table "profiles", :force => true do |t|
    t.string   "full_name"
    t.date     "birth_date"
    t.text     "bio"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

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

end
