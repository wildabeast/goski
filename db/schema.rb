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

ActiveRecord::Schema.define(version: 2022_12_25_033339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ticket_prices", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "fetched_at"
    t.index ["ticket_id"], name: "index_ticket_prices_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.text "description"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["start_datetime", "end_datetime"], name: "index_tickets_on_start_datetime_and_end_datetime"
  end

  add_foreign_key "ticket_prices", "tickets"
end
