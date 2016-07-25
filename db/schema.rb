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

ActiveRecord::Schema.define(version: 20160725141551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "accounts", force: :cascade do |t|
    t.string   "account_status",                 default: "new"
    t.string   "stripe_plan_id"
    t.string   "paid_status",                    default: "unpaid"
    t.string   "payment_method"
    t.string   "stripe_customer_default_source"
    t.integer  "free_connections_used",          default: 0
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "free_call_connections_used",     default: 0
    t.string   "stripe_customer_id"
    t.datetime "valid_until"
    t.integer  "company_id"
    t.integer  "transaction_rate"
    t.integer  "internal_promo_code_id"
    t.datetime "subscription_start_date"
  end

  add_index "accounts", ["account_status"], name: "index_accounts_on_account_status", using: :btree
  add_index "accounts", ["company_id"], name: "index_accounts_on_company_id", using: :btree
  add_index "accounts", ["paid_status"], name: "index_accounts_on_paid_status", using: :btree
  add_index "accounts", ["stripe_customer_id"], name: "index_accounts_on_stripe_customer_id", using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "avatars", force: :cascade do |t|
    t.integer "image_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  create_table "call_requests", force: :cascade do |t|
    t.integer  "requestor_user_id"
    t.integer  "recipient_user_id"
    t.string   "state",             default: "active"
    t.datetime "expires_at"
    t.datetime "scheduled_at"
    t.datetime "called_at"
    t.datetime "call_ended_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "participants",      default: 0
    t.string   "recording_url"
    t.integer  "duration"
  end

  add_index "call_requests", ["recipient_user_id"], name: "index_call_requests_on_recipient_user_id", using: :btree
  add_index "call_requests", ["requestor_user_id"], name: "index_call_requests_on_requestor_user_id", using: :btree

  create_table "change_password_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "company_name",        limit: 100, default: ""
    t.text     "company_description",             default: ""
    t.string   "company_url",                     default: ""
    t.string   "company_size",                    default: ""
    t.text     "company_pitch",                   default: ""
    t.text     "company_product",                 default: ""
    t.string   "company_mission",                 default: ""
    t.string   "company_logo",                    default: ""
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "account_id"
  end

  add_index "companies", ["account_id"], name: "index_companies_on_account_id", using: :btree

  create_table "company_roles", force: :cascade do |t|
    t.string "role_type"
  end

  create_table "email_event_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email_type"
    t.boolean  "email_sent"
    t.text     "email_detail_jstr"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "job_id"
    t.integer  "profile_id"
  end

  add_index "email_event_histories", ["user_id", "email_type", "job_id"], name: "email_type_user_job", using: :btree
  add_index "email_event_histories", ["user_id", "email_type", "profile_id"], name: "email_type_user_profile", using: :btree
  add_index "email_event_histories", ["user_id", "email_type"], name: "index_email_event_histories_on_user_id_and_email_type", using: :btree
  add_index "email_event_histories", ["user_id"], name: "index_email_event_histories_on_user_id", using: :btree

  create_table "email_settings", force: :cascade do |t|
    t.integer "user_id"
    t.string  "email_type"
    t.boolean "enabled"
  end

  add_index "email_settings", ["email_type", "user_id"], name: "index_email_settings_on_email_type_and_user_id", unique: true, using: :btree

  create_table "exclusion_histories", force: :cascade do |t|
    t.integer  "user_id",             null: false
    t.integer  "excluded_listing_id"
    t.string   "excluded_type"
    t.integer  "excluded_id"
    t.string   "detail_reason"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "utc_offset",      limit: 8
    t.integer  "rsvp_limit"
    t.float    "distance"
    t.float    "fee_amount"
    t.integer  "yes_rsvp_count"
    t.integer  "duration",        limit: 8
    t.string   "name"
    t.string   "game_id"
    t.integer  "time",            limit: 8
    t.integer  "game_updated",    limit: 8
    t.string   "group_name"
    t.float    "group_lon"
    t.float    "group_lat"
    t.integer  "group_id"
    t.string   "group_urlname"
    t.string   "group_who"
    t.string   "status"
    t.string   "day_of_the_week"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "loc_lat"
    t.float    "loc_lon"
    t.string   "loc_name"
    t.string   "event_url"
    t.boolean  "display"
  end

  create_table "hires", force: :cascade do |t|
    t.integer  "job_id",                                        null: false
    t.integer  "hired_user_id",                                 null: false
    t.integer  "hired_amount"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "payment_collected",             default: false
    t.integer  "job_payment_detail_history_id"
  end

  add_index "hires", ["hired_user_id"], name: "index_hires_on_hired_user_id", using: :btree
  add_index "hires", ["job_id"], name: "index_hires_on_job_id", using: :btree

  create_table "inactive_reasons", force: :cascade do |t|
    t.string   "status"
    t.string   "detail"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internal_promo_codes", force: :cascade do |t|
    t.string   "promo_code",                  default: ""
    t.integer  "monthly_percentage_discount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_payment_detail_histories", force: :cascade do |t|
    t.integer  "job_payment_detail_id"
    t.integer  "stripe_charge_log_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "charge_amount"
    t.string   "charge_status"
    t.integer  "hire_id"
    t.integer  "transaction_log_id"
  end

  add_index "job_payment_detail_histories", ["job_payment_detail_id"], name: "index_job_payment_detail_histories_on_job_payment_detail_id", using: :btree
  add_index "job_payment_detail_histories", ["stripe_charge_log_id"], name: "index_job_payment_detail_histories_on_stripe_charge_log_id", using: :btree

  create_table "job_payment_details", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "deposit_amount", default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "job_payment_details", ["job_id"], name: "index_job_payment_details_on_job_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.integer  "user_id",                                                  null: false
    t.string   "internal_name",                       default: ""
    t.string   "state",                               default: "active"
    t.string   "category"
    t.string   "photo_url",                           default: ""
    t.text     "job_description",                     default: ""
    t.string   "first_name",              limit: 100, default: ""
    t.string   "last_name",               limit: 100, default: ""
    t.text     "looking_for_skills_jstr",             default: "[]"
    t.string   "work_type"
    t.string   "fb_uid",                  limit: 100
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "location_input"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "location_display_name"
    t.string   "job_title",                           default: ""
    t.decimal  "min_hourly"
    t.decimal  "min_salary"
    t.string   "approved",                            default: "false"
    t.boolean  "remote_ok"
    t.decimal  "max_hourly"
    t.decimal  "max_salary"
    t.string   "phone_number"
    t.string   "slug"
    t.integer  "min_level"
    t.integer  "max_level"
    t.string   "specialty_jstr"
    t.boolean  "internship"
    t.boolean  "contract"
    t.boolean  "permanent"
    t.boolean  "off_site"
    t.boolean  "on_site"
    t.boolean  "full_time"
    t.boolean  "part_time"
    t.text     "secondary_skills_jstr",               default: "[]"
    t.string   "type",                                default: "Position"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "budget"
    t.text     "project_type_jstr"
    t.integer  "monthly_rate_in_cents"
  end

  add_index "jobs", ["slug"], name: "index_jobs_on_slug", unique: true, using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "lt_apns", force: :cascade do |t|
    t.integer "user_id"
    t.string  "token",   limit: 1024
  end

  add_index "lt_apns", ["token"], name: "index_lt_apns_on_token", unique: true, using: :btree
  add_index "lt_apns", ["user_id"], name: "index_lt_apns_on_user_id", using: :btree

  create_table "lt_transaction_log", force: :cascade do |t|
    t.integer  "admin_id"
    t.string   "type"
    t.string   "stripe_transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lt_transaction_logs", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "lt_transaction_type"
    t.string   "stripe_transaction_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "ltimages", force: :cascade do |t|
    t.string   "name"
    t.binary   "image_data"
    t.string   "hash_val"
    t.string   "file_type"
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "match_messages", force: :cascade do |t|
    t.integer  "match_id"
    t.string   "sender_type"
    t.text     "message_jstr"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "match_messages", ["match_id"], name: "index_match_messages_on_match_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "profile_id"
    t.string   "profile_state",      default: "active"
    t.string   "job_state",          default: "active"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "unread_for_job",     default: true
    t.boolean  "unread_for_profile", default: true
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "state",                               default: "active"
    t.string   "category"
    t.string   "photo_url",                           default: ""
    t.string   "first_name",              limit: 100, default: ""
    t.string   "last_name",               limit: 100, default: ""
    t.text     "profile_description",                 default: ""
    t.text     "top_skills_jstr",                     default: "[]"
    t.text     "other_skills_jstr",                   default: "[]"
    t.integer  "level"
    t.string   "fb_uid",                  limit: 100
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "internal_name",                       default: ""
    t.string   "location_input"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "location_display_name"
    t.float    "typical_rate"
    t.string   "specialty_jstr"
    t.boolean  "onsite_only_ok"
    t.string   "github",                              default: ""
    t.string   "portfolio",                           default: ""
    t.string   "blog",                                default: ""
    t.text     "question_motivation",                 default: ""
    t.text     "question_accomplishment",             default: ""
    t.text     "question_process",                    default: ""
    t.string   "approved",                            default: "false"
    t.text     "projects_jstr",                       default: "[{}]"
    t.string   "linkedin",                            default: ""
    t.boolean  "full_time_ok"
    t.string   "github_repos_jstr"
    t.string   "phone_number"
    t.string   "twitter",                             default: ""
    t.float    "salary"
    t.string   "slug"
    t.integer  "internal_ranking"
    t.string   "work_type"
    t.boolean  "intern",                              default: false
    t.text     "intern_info_jstr"
    t.boolean  "contract"
    t.boolean  "permanent"
    t.boolean  "off_site"
    t.boolean  "on_site"
    t.boolean  "full_time"
    t.boolean  "part_time"
    t.boolean  "open_to_relocate",                    default: false
    t.text     "secondary_skills_jstr",               default: "[]"
    t.boolean  "freelance",                           default: false
  end

  add_index "profiles", ["slug"], name: "index_profiles_on_slug", unique: true, using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "project_types", force: :cascade do |t|
    t.string   "title"
    t.string   "project_type"
    t.text     "rec_specialties_jstr"
    t.text     "rec_skills_jstr"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "category"
  end

  create_table "referred_bies", force: :cascade do |t|
    t.string   "referral_code"
    t.string   "referral_status", default: "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "referred_bies", ["referral_code"], name: "index_referred_bies_on_referral_code", using: :btree
  add_index "referred_bies", ["user_id"], name: "index_referred_bies_on_user_id", using: :btree

  create_table "saved_searches", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "search_type"
    t.string   "filter_category_jstr",     default: "[]"
    t.string   "filter_skills_jstr",       default: "[]"
    t.string   "filter_specialty_jstr",    default: "[]"
    t.string   "filter_company_size_jstr", default: "[]"
    t.boolean  "filter_remote_only"
    t.boolean  "filter_onsite_only"
    t.string   "filter_work_type"
    t.integer  "filter_level_min"
    t.integer  "filter_level_max"
    t.integer  "filter_level"
    t.boolean  "filter_has_phone_number"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "search_name"
    t.text     "params_jstr"
  end

  create_table "screenshots", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.string   "skill_type"
    t.string   "assessment_id_jstr"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "frequency"
  end

  create_table "sms_event_histories", force: :cascade do |t|
    t.string   "sms_message_type"
    t.integer  "to_user_id"
    t.string   "text_detail_jstr"
    t.string   "sms_sid"
    t.string   "sms_status"
    t.string   "sms_error_code"
    t.integer  "match_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "from_user_id"
    t.string   "to_phone_number"
  end

  add_index "sms_event_histories", ["match_id"], name: "index_sms_event_histories_on_match_id", using: :btree
  add_index "sms_event_histories", ["sms_message_type"], name: "index_sms_event_histories_on_sms_message_type", using: :btree
  add_index "sms_event_histories", ["sms_sid"], name: "index_sms_event_histories_on_sms_sid", using: :btree
  add_index "sms_event_histories", ["to_phone_number", "match_id", "sms_message_type"], name: "sms_type_match_to", using: :btree
  add_index "sms_event_histories", ["to_user_id", "from_user_id"], name: "sms_to_from", using: :btree
  add_index "sms_event_histories", ["to_user_id"], name: "index_sms_event_histories_on_to_user_id", using: :btree

  create_table "specialties", force: :cascade do |t|
    t.string   "name"
    t.string   "discipline"
    t.string   "vertical"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stripe_charge_logs", force: :cascade do |t|
    t.integer  "account_id",                                  null: false
    t.integer  "charge_amount"
    t.string   "stripe_charge_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "charge_status",           default: "success"
    t.integer  "initial_amount"
    t.integer  "deposit_amount"
    t.integer  "transaction_percent_tax"
  end

  create_table "transaction_logs", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "lt_transaction_type"
    t.string   "stripe_transaction_id"
    t.string   "stripe_transaction_type"
    t.string   "stripe_source_id"
    t.integer  "lt_initial_amount"
    t.integer  "lt_deposit_amount"
    t.integer  "lt_placement_percent_fee"
    t.integer  "amount"
    t.integer  "stripe_fee"
    t.integer  "net_charge_amount"
    t.string   "stripe_status"
    t.string   "captured"
    t.string   "stripe_customer_id"
    t.string   "stripe_customer_email"
    t.string   "stripe_payment_source"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type"
    t.float    "score"
    t.text     "review_details_jstr"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.float    "gh_skills_match"
    t.float    "gh_contributions"
  end

  add_index "user_ratings", ["user_id"], name: "index_user_ratings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest",                                   default: "",       null: false
    t.string   "first_name",                           limit: 100,  default: ""
    t.string   "last_name",                            limit: 100,  default: ""
    t.string   "photo_url",                                         default: ""
    t.string   "user_type",                                         default: "none"
    t.string   "auth_token"
    t.string   "access_token",                         limit: 1024
    t.string   "fb_uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location_input"
    t.string   "person_lookup_jstr"
    t.string   "phone_number"
    t.integer  "account_id"
    t.boolean  "sms_enabled",                                       default: true
    t.string   "twilio_number"
    t.integer  "company_id"
    t.string   "time_zone_id"
    t.string   "account_privacy_level",                             default: "public"
    t.string   "linked_in_access_token",                            default: ""
    t.string   "slug"
    t.string   "linked_in_id"
    t.integer  "company_role_id"
    t.string   "google_access_token",                               default: ""
    t.string   "google_refresh_token",                              default: ""
    t.datetime "last_logged_in"
    t.boolean  "send_cal_reminder_for_scheduled_call",              default: true
    t.string   "approved",                                          default: "false"
    t.string   "referral_code"
    t.integer  "referred_by_id"
    t.boolean  "intern_permission",                                 default: false
    t.boolean  "chat_permission",                                   default: false
    t.boolean  "us_authorized",                                     default: true
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["company_role_id"], name: "index_users_on_company_role_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["linked_in_id"], name: "index_users_on_linked_in_id", unique: true, using: :btree
  add_index "users", ["phone_number"], name: "index_users_on_phone_number", using: :btree
  add_index "users", ["referral_code"], name: "index_users_on_referral_code", unique: true, using: :btree
  add_index "users", ["referred_by_id"], name: "index_users_on_referred_by_id", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "vote_on_profiles", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "profile_id"
    t.string   "decision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vote_on_profiles", ["job_id"], name: "index_vote_on_profiles_on_job_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  create_table "votes_on_jobs", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "profile_id"
    t.string   "decision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes_on_jobs", ["profile_id"], name: "index_votes_on_jobs_on_profile_id", using: :btree

  add_foreign_key "user_ratings", "users"
end
