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

ActiveRecord::Schema.define(version: 2018_07_16_121732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animal_breeds", force: :cascade do |t|
    t.string "name"
    t.bigint "animal_species_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_species_id"], name: "index_animal_breeds_on_animal_species_id"
  end

  create_table "animal_species", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.date "birthdate_rescuedate"
    t.boolean "rescued"
    t.boolean "adopted"
    t.date "adoption_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "animal_breeds_id"
    t.string "profile_picture"
    t.index ["animal_breeds_id"], name: "index_animals_on_animal_breeds_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "email"
    t.string "address"
    t.string "home_phone"
    t.string "cellphone"
    t.string "country"
    t.string "job_position"
    t.string "job_address"
    t.string "job_phone"
    t.text "references", default: [], array: true
    t.boolean "other_pets"
    t.text "different_pet", default: [], array: true
    t.boolean "puppy"
    t.text "family_members", default: [], array: true
    t.boolean "all_agree"
    t.string "type_of_home"
    t.boolean "own_home"
    t.string "place_to_be"
    t.string "place_to_sleep"
    t.boolean "has_garden"
    t.boolean "can_escape"
    t.string "signature"
    t.string "status"
    t.bigint "animal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_requests_on_animal_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "animal_breeds", "animal_species", column: "animal_species_id"
  add_foreign_key "animals", "animal_breeds", column: "animal_breeds_id"
end
