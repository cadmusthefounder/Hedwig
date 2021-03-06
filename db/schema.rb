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

ActiveRecord::Schema.define(version: 20160720120012) do

  create_table "interests", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "last_sent_at"
    t.boolean  "read_by_owner", default: false, null: false
    t.boolean  "read_by_user",  default: true,  null: false
    t.index ["task_id"], name: "index_interests_on_task_id"
    t.index ["user_id"], name: "index_interests_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "message"
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["interest_id"], name: "index_messages_on_interest_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "owner_id"
    t.index ["owner_id"], name: "index_reviews_on_owner_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "remember_token"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "online",         default: true
    t.index ["remember_token"], name: "index_sessions_on_remember_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "from_address"
    t.string   "from_postal_code"
    t.string   "to_address"
    t.string   "to_postal_code"
    t.decimal  "price",            precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.integer  "status",                                    default: 0
    t.integer  "user_id"
    t.integer  "assigned_user_id"
    t.string   "completion_token"
    t.index ["assigned_user_id"], name: "index_tasks_on_assigned_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount",           default: "0.0", null: false
    t.integer  "status",           default: 0,     null: false
    t.integer  "transaction_type", default: 0,     null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "account_kit_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.decimal  "credit",         default: "0.0", null: false
    t.boolean  "admin",          default: false, null: false
    t.index ["account_kit_id"], name: "index_users_on_account_kit_id", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
