# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_02_27_092755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "subdomain", null: false
    t.string "slug", null: false
    t.integer "plan_type", default: 0, null: false
    t.string "phone"
    t.string "email"
    t.string "website"
    t.text "address"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_accounts_on_active"
    t.index ["slug"], name: "index_accounts_on_slug", unique: true
    t.index ["subdomain"], name: "index_accounts_on_subdomain", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "event_vendors", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.bigint "vendor_id", null: false
    t.decimal "contracted_amount", precision: 12, scale: 2, default: "0.0"
    t.decimal "paid_amount", precision: 12, scale: 2, default: "0.0"
    t.integer "status", default: 0, null: false
    t.text "notes"
    t.date "service_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_event_vendors_on_account_id"
    t.index ["event_id", "status"], name: "index_event_vendors_on_event_id_and_status"
    t.index ["event_id", "vendor_id"], name: "index_event_vendors_on_event_id_and_vendor_id", unique: true
    t.index ["event_id"], name: "index_event_vendors_on_event_id"
    t.index ["vendor_id"], name: "index_event_vendors_on_vendor_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "planner_id"
    t.bigint "client_id"
    t.string "title", null: false
    t.string "slug", null: false
    t.text "description"
    t.integer "event_type", default: 0
    t.date "event_date"
    t.time "start_time"
    t.time "end_time"
    t.string "venue"
    t.text "venue_address"
    t.integer "status", default: 0, null: false
    t.decimal "budget_total", precision: 12, scale: 2, default: "0.0"
    t.integer "estimated_guests", default: 0
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "event_date"], name: "index_events_on_account_id_and_event_date"
    t.index ["account_id", "status"], name: "index_events_on_account_id_and_status"
    t.index ["account_id"], name: "index_events_on_account_id"
    t.index ["client_id"], name: "index_events_on_client_id"
    t.index ["planner_id"], name: "index_events_on_planner_id"
    t.index ["slug"], name: "index_events_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "guests", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email"
    t.string "phone"
    t.integer "rsvp_status", default: 0, null: false
    t.text "dietary_notes"
    t.integer "table_number"
    t.integer "party_size", default: 1
    t.string "meal_choice"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_guests_on_account_id"
    t.index ["event_id", "email"], name: "index_guests_on_event_id_and_email"
    t.index ["event_id", "rsvp_status"], name: "index_guests_on_event_id_and_rsvp_status"
    t.index ["event_id", "table_number"], name: "index_guests_on_event_id_and_table_number"
    t.index ["event_id"], name: "index_guests_on_event_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.bigint "event_vendor_id"
    t.string "category", null: false
    t.string "description", null: false
    t.decimal "estimated_cost", precision: 12, scale: 2, default: "0.0"
    t.decimal "actual_cost", precision: 12, scale: 2, default: "0.0"
    t.boolean "paid", default: false, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_line_items_on_account_id"
    t.index ["event_id", "category"], name: "index_line_items_on_event_id_and_category"
    t.index ["event_id", "paid"], name: "index_line_items_on_event_id_and_paid"
    t.index ["event_id"], name: "index_line_items_on_event_id"
    t.index ["event_vendor_id"], name: "index_line_items_on_event_vendor_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.bigint "assigned_to_id"
    t.bigint "created_by_id"
    t.string "title", null: false
    t.text "description"
    t.date "due_date"
    t.integer "status", default: 0, null: false
    t.integer "priority", default: 1, null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_tasks_on_account_id"
    t.index ["assigned_to_id", "status"], name: "index_tasks_on_assigned_to_id_and_status"
    t.index ["assigned_to_id"], name: "index_tasks_on_assigned_to_id"
    t.index ["created_by_id"], name: "index_tasks_on_created_by_id"
    t.index ["event_id", "due_date"], name: "index_tasks_on_event_id_and_due_date"
    t.index ["event_id", "position"], name: "index_tasks_on_event_id_and_position"
    t.index ["event_id", "status"], name: "index_tasks_on_event_id_and_status"
    t.index ["event_id"], name: "index_tasks_on_event_id"
  end

  create_table "timelines", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.time "start_time", null: false
    t.time "end_time"
    t.string "title", null: false
    t.text "description"
    t.string "responsible_party"
    t.string "location"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_timelines_on_account_id"
    t.index ["event_id", "position"], name: "index_timelines_on_event_id_and_position"
    t.index ["event_id", "start_time"], name: "index_timelines_on_event_id_and_start_time"
    t.index ["event_id"], name: "index_timelines_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "role", default: 0, null: false
    t.string "phone"
    t.string "slug", null: false
    t.boolean "active", default: true, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "designation"
    t.index ["account_id", "role"], name: "index_users_on_account_id_and_role"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id"
    t.string "name", null: false
    t.string "slug", null: false
    t.integer "category", default: 0
    t.string "email"
    t.string "phone"
    t.string "website"
    t.text "address"
    t.text "notes"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "active"], name: "index_vendors_on_account_id_and_active"
    t.index ["account_id", "category"], name: "index_vendors_on_account_id_and_category"
    t.index ["account_id"], name: "index_vendors_on_account_id"
    t.index ["slug"], name: "index_vendors_on_slug", unique: true
    t.index ["user_id"], name: "index_vendors_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "event_vendors", "accounts"
  add_foreign_key "event_vendors", "events"
  add_foreign_key "event_vendors", "vendors"
  add_foreign_key "events", "accounts"
  add_foreign_key "events", "users", column: "client_id"
  add_foreign_key "events", "users", column: "planner_id"
  add_foreign_key "guests", "accounts"
  add_foreign_key "guests", "events"
  add_foreign_key "line_items", "accounts"
  add_foreign_key "line_items", "event_vendors"
  add_foreign_key "line_items", "events"
  add_foreign_key "tasks", "accounts"
  add_foreign_key "tasks", "events"
  add_foreign_key "tasks", "users", column: "assigned_to_id"
  add_foreign_key "tasks", "users", column: "created_by_id"
  add_foreign_key "timelines", "accounts"
  add_foreign_key "timelines", "events"
  add_foreign_key "users", "accounts"
  add_foreign_key "vendors", "accounts"
  add_foreign_key "vendors", "users"
end
