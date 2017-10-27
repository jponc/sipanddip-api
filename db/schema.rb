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

ActiveRecord::Schema.define(version: 20171027162906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_records", force: :cascade do |t|
    t.date "record_date", null: false
    t.decimal "gross_sales", precision: 7, scale: 2, default: "0.0"
    t.decimal "expenses", precision: 7, scale: 2, default: "0.0"
    t.decimal "deposit_amount", precision: 7, scale: 2, default: "0.0"
    t.integer "food_cups_count", default: 0
    t.integer "drink_cups_count", default: 0
    t.string "prepared_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pwd_count", default: 0
    t.integer "discount_count", default: 0
    t.decimal "discrepancy", precision: 7, scale: 2, default: "0.0"
    t.text "notes"
    t.index ["record_date"], name: "index_daily_records_on_record_date"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name"
    t.integer "restock_trigger_count", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_inventories_on_slug"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.integer "in_count"
    t.integer "out_count"
    t.integer "total_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "inventory_id"
    t.bigint "daily_record_id"
    t.index ["daily_record_id"], name: "index_inventory_items_on_daily_record_id"
    t.index ["inventory_id"], name: "index_inventory_items_on_inventory_id"
  end

  add_foreign_key "inventory_items", "daily_records"
  add_foreign_key "inventory_items", "inventories"
end
