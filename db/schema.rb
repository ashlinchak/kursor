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

ActiveRecord::Schema.define(:version => 20111127145218) do

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
  end

  add_index "contacts", ["provider_id"], :name => "index_contacts_on_provider_id"

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

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "logo"
    t.boolean  "is_approved", :default => false
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
    t.boolean  "is_active",     :default => false
  end

end
