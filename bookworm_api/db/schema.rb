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

ActiveRecord::Schema.define(version: 2020_03_14_044859) do

  create_table "accounts", force: :cascade do |t|
    t.string "number"
    t.decimal "initial_balance"
    t.string "holder_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn", null: false
    t.string "title", null: false
    t.string "author"
    t.date "published_on"
    t.integer "quantity", default: 0, null: false
    t.decimal "fee", default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["isbn"], name: "index_books_on_isbn", unique: true
  end

  create_table "librarians", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_librarians_on_email", unique: true
  end

  create_table "loans", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "book_id", null: false
    t.decimal "fee", default: "0.0", null: false
    t.datetime "concluded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_loans_on_account_id"
    t.index ["book_id"], name: "index_loans_on_book_id"
    t.index ["concluded_at"], name: "index_loans_on_concluded_at"
  end

  add_foreign_key "loans", "accounts"
  add_foreign_key "loans", "books"
end
