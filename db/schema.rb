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

ActiveRecord::Schema[7.2].define(version: 2025_01_21_113533) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string "token"
    t.string "name"
    t.integer "chat_sequence", default: 0
    t.integer "chat_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_apps_on_token", unique: true
  end

  create_table "chats", force: :cascade do |t|
    t.string "app_token"
    t.integer "number"
    t.integer "message_count", default: 0
    t.integer "message_sequence", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_token", "number"], name: "index_chats_on_app_token_and_number", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.string "app_token"
    t.integer "chat_number"
    t.integer "number"
    t.text "text"
    t.string "sender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_token", "chat_number"], name: "index_messages_on_app_token_and_chat_number"
  end

  add_foreign_key "chats", "apps", column: "app_token", primary_key: "token"
  add_foreign_key "messages", "chats", column: ["app_token", "chat_number"], primary_key: ["app_token", "number"]
end
