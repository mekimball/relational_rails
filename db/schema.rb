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

ActiveRecord::Schema.define(version: 2021_10_19_165503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beers", force: :cascade do |t|
    t.string "name"
    t.float "abv"
    t.boolean "is_an_ale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brewery_id"
    t.index ["brewery_id"], name: "index_beers_on_brewery_id"
  end

  create_table "breweries", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_employees"
    t.boolean "has_food"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_groups", force: :cascade do |t|
    t.string "name"
    t.float "rating_out_of_ten"
    t.boolean "perishable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.integer "number_in_stock"
    t.boolean "in_stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "food_group_id"
    t.index ["food_group_id"], name: "index_foods_on_food_group_id"
  end

  add_foreign_key "beers", "breweries"
  add_foreign_key "foods", "food_groups"
end
