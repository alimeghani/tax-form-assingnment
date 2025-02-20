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

ActiveRecord::Schema.define(version: 2020_07_19_093808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forms", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_system_generated", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "system_generated_forms", force: :cascade do |t|
    t.decimal "total_taxpaid"
    t.decimal "total_tax_liability"
    t.integer "total_difference"
    t.decimal "total_taxable_income"
    t.bigint "user_id"
    t.bigint "form_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_system_generated_forms_on_form_id"
    t.index ["user_id"], name: "index_system_generated_forms_on_user_id"
  end

  create_table "user_input_forms", force: :cascade do |t|
    t.decimal "total_income"
    t.decimal "total_business_expenses"
    t.integer "total_miles_driven"
    t.decimal "total_tax_paid"
    t.decimal "total_taxable_income"
    t.bigint "user_id"
    t.bigint "form_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_user_input_forms_on_form_id"
    t.index ["user_id"], name: "index_user_input_forms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "system_generated_forms", "forms"
  add_foreign_key "system_generated_forms", "users"
  add_foreign_key "user_input_forms", "forms"
  add_foreign_key "user_input_forms", "users"
end
