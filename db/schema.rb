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

ActiveRecord::Schema.define(version: 2020_02_22_224228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomplishment_categories", force: :cascade do |t|
    t.bigint "accomplishment_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accomplishment_id"], name: "index_accomplishment_categories_on_accomplishment_id"
    t.index ["category_id"], name: "index_accomplishment_categories_on_category_id"
  end

  create_table "accomplishment_types", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description_template"
    t.index ["user_id"], name: "index_accomplishment_types_on_user_id"
  end

  create_table "accomplishments", force: :cascade do |t|
    t.date "date", null: false
    t.text "description"
    t.text "given_by"
    t.bigint "accomplishment_type_id", null: false
    t.string "url"
    t.boolean "bookmarked", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_url"
    t.index ["accomplishment_type_id"], name: "index_accomplishments_on_accomplishment_type_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.boolean "admin", default: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accomplishment_categories", "accomplishments"
  add_foreign_key "accomplishment_categories", "categories"
  add_foreign_key "accomplishment_types", "users"
  add_foreign_key "accomplishments", "accomplishment_types"
  add_foreign_key "categories", "users"
end
