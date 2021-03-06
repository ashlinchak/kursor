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

ActiveRecord::Schema.define(:version => 20130131135732) do

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
    t.boolean  "gmaps"
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

  create_table "adv_categories", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.string   "ancestry"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "position",       :default => 0, :null => false
    t.integer  "postings_count", :default => 0
  end

  add_index "adv_categories", ["ancestry"], :name => "index_adv_categories_on_ancestry"

  create_table "adv_postings", :force => true do |t|
    t.string   "title"
    t.integer  "adv_category_id"
    t.integer  "posting_type_id"
    t.integer  "owner_type_id"
    t.text     "body"
    t.integer  "location_id"
    t.string   "contact_person"
    t.string   "email"
    t.integer  "price"
    t.datetime "published_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.integer  "position",        :default => 0, :null => false
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["permalink"], :name => "index_categories_on_permalink"

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

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "event_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "parent_id"
    t.string   "permalink"
    t.integer  "position",    :default => 0, :null => false
  end

  add_index "event_categories", ["parent_id"], :name => "index_event_categories_on_parent_id"

  create_table "event_categorizings", :force => true do |t|
    t.integer  "event_id"
    t.integer  "event_category_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "event_categorizings", ["event_category_id"], :name => "index_event_categorizings_on_event_category_id"
  add_index "event_categorizings", ["event_id"], :name => "index_event_categorizings_on_event_id"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.integer  "location_id"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.integer  "min_price"
    t.integer  "max_price"
    t.string   "teacher"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "filials", :force => true do |t|
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "filials", ["provider_id"], :name => "index_filials_on_provider_id"

  create_table "forem_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "forem_categories", ["slug"], :name => "index_forem_categories_on_slug", :unique => true

  create_table "forem_forums", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", :default => 0
    t.string  "slug"
  end

  add_index "forem_forums", ["slug"], :name => "index_forem_forums_on_slug", :unique => true

  create_table "forem_groups", :force => true do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], :name => "index_forem_groups_on_name"

  create_table "forem_memberships", :force => true do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], :name => "index_forem_memberships_on_group_id"

  create_table "forem_moderator_groups", :force => true do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], :name => "index_forem_moderator_groups_on_forum_id"

  create_table "forem_posts", :force => true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "reply_to_id"
    t.string   "state",       :default => "pending_review"
    t.boolean  "notified",    :default => false
  end

  add_index "forem_posts", ["reply_to_id"], :name => "index_forem_posts_on_reply_to_id"
  add_index "forem_posts", ["state"], :name => "index_forem_posts_on_state"
  add_index "forem_posts", ["topic_id"], :name => "index_forem_posts_on_topic_id"
  add_index "forem_posts", ["user_id"], :name => "index_forem_posts_on_user_id"

  create_table "forem_subscriptions", :force => true do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "locked",       :default => false,            :null => false
    t.boolean  "pinned",       :default => false
    t.boolean  "hidden",       :default => false
    t.datetime "last_post_at"
    t.string   "state",        :default => "pending_review"
    t.integer  "views_count",  :default => 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], :name => "index_forem_topics_on_forum_id"
  add_index "forem_topics", ["slug"], :name => "index_forem_topics_on_slug", :unique => true
  add_index "forem_topics", ["state"], :name => "index_forem_topics_on_state"
  add_index "forem_topics", ["user_id"], :name => "index_forem_topics_on_user_id"

  create_table "forem_views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             :default => 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], :name => "index_forem_views_on_updated_at"
  add_index "forem_views", ["user_id"], :name => "index_forem_views_on_user_id"
  add_index "forem_views", ["viewable_id"], :name => "index_forem_views_on_topic_id"

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

  create_table "metatags", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.text     "additional"
    t.boolean  "split_keywords"
    t.integer  "metatagable_id"
    t.string   "metatagable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "metatags", ["metatagable_id"], :name => "index_metatags_on_metatagable_id"
  add_index "metatags", ["metatagable_type"], :name => "index_metatags_on_metatagable_type"

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
    t.integer  "position",    :default => 0,     :null => false
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
    t.integer  "posting_type_id", :default => 0
    t.datetime "published_at"
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

  create_table "promotions", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "promotionable_id"
    t.string   "promotionable_type"
    t.boolean  "is_featured"
    t.boolean  "is_vip"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "position",           :default => 0, :null => false
  end

  add_index "promotions", ["promotionable_id"], :name => "index_promotions_on_promotionable_id"
  add_index "promotions", ["promotionable_type"], :name => "index_promotions_on_promotionable_type"

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
    t.integer  "position",     :default => 0, :null => false
    t.string   "icon"
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
    t.string   "email",                  :default => ""
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",              :default => false
    t.integer  "account_type_id",        :default => 0
    t.string   "nickname"
    t.string   "encrypted_password",     :default => "",               :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "oauth_provider"
    t.string   "uid"
    t.boolean  "forem_admin",            :default => false
    t.string   "forem_state",            :default => "pending_review"
    t.boolean  "forem_auto_subscribe",   :default => false
    t.integer  "postings_count",         :default => 0
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "vacancies", :force => true do |t|
    t.string   "title"
    t.text     "requirements"
    t.text     "responsibility"
    t.text     "conditions"
    t.string   "salary"
    t.boolean  "active"
    t.integer  "vacancyable_id"
    t.string   "vacancyable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
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
