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

ActiveRecord::Schema.define(version: 2020_08_16_195041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animal_breeds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "animal_specy_id"
    t.index ["animal_specy_id"], name: "index_animal_breeds_on_animal_specy_id"
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

  create_table "references", force: :cascade do |t|
    t.string "full_name"
    t.string "phone"
    t.bigint "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_references_on_request_id"
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
    t.boolean "other_pets"
    t.text "different_pet", default: [], array: true
    t.boolean "puppy"
    t.string "family_members"
    t.boolean "all_agree"
    t.string "type_of_home"
    t.boolean "own_home"
    t.string "place_to_be"
    t.string "place_to_sleep"
    t.boolean "has_garden"
    t.boolean "can_escape"
    t.string "signature"
    t.string "status", default: "pending"
    t.bigint "animal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_requests_on_animal_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
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

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "animal_breeds", "animal_species"
  add_foreign_key "animals", "animal_breeds", column: "animal_breeds_id"
  add_foreign_key "references", "requests"
end
