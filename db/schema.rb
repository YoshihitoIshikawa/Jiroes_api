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

ActiveRecord::Schema.define(version: 2023_12_22_053150) do

  create_table "likes", force: :cascade do |t|
    t.string "sub", null: false
    t.integer "review_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "shop_id", null: false
    t.index ["review_id"], name: "index_likes_on_review_id"
    t.index ["shop_id"], name: "index_likes_on_shop_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.text "caption"
    t.integer "score"
    t.string "sub", null: false
    t.integer "shop_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number_of_likes", default: 0
    t.index ["shop_id"], name: "index_reviews_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.string "access"
    t.string "parking"
    t.string "open_time"
    t.string "closed_days"
    t.text "menu"
    t.text "remarks"
    t.text "prohibited_matters"
    t.text "when_to_buy_tickets"
    t.text "number_of_seats"
    t.text "call_timing"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "users", primary_key: "sub", id: :string, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "picture"
  end

  add_foreign_key "likes", "reviews"
  add_foreign_key "likes", "shops"
  add_foreign_key "likes", "users", column: "sub", primary_key: "sub"
  add_foreign_key "reviews", "shops"
  add_foreign_key "reviews", "users", column: "sub", primary_key: "sub"
end
