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

ActiveRecord::Schema[7.1].define(version: 2024_04_27_081042) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "menu_id"
    t.integer "qty"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["menu_id"], name: "index_cart_items_on_menu_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id"
    t.string "pincode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "item_name"
    t.string "item_type"
    t.integer "price"
    t.integer "stock"
    t.integer "rating"
    t.boolean "available"
    t.bigint "restaurant_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_detail_id"], name: "index_menus_on_restaurant_detail_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "menu_id"
    t.string "item_name"
    t.string "item_type"
    t.integer "qty"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_order_items_on_menu_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.float "gross_amount"
    t.bigint "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_details_id"
    t.index ["restaurant_details_id"], name: "index_orders_on_restaurant_details_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "order_id"
    t.float "gross_amount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "order_item_id"
    t.bigint "menu_id"
    t.bigint "user_id"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_ratings_on_menu_id"
    t.index ["order_item_id"], name: "index_ratings_on_order_item_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "restaurant_details", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "address"
    t.bigint "city_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_restaurant_details_on_city_id"
    t.index ["user_id"], name: "index_restaurant_details_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "city_id"
    t.string "contact"
    t.string "email"
    t.string "password"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.index ["city_id"], name: "index_users_on_city_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "menus"
  add_foreign_key "carts", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "menus", "restaurant_details"
  add_foreign_key "order_items", "menus"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "restaurant_details", column: "restaurant_details_id"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "ratings", "menus"
  add_foreign_key "ratings", "order_items"
  add_foreign_key "ratings", "users"
  add_foreign_key "restaurant_details", "cities"
  add_foreign_key "restaurant_details", "users"
  add_foreign_key "users", "cities"
end
