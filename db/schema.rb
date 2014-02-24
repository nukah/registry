# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140224130530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "buildings", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "certificate"
    t.integer  "territory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "technical_passport_file_name"
    t.string   "technical_passport_content_type"
    t.integer  "technical_passport_file_size"
    t.datetime "technical_passport_updated_at"
    t.string   "building_passport_file_name"
    t.string   "building_passport_content_type"
    t.integer  "building_passport_file_size"
    t.datetime "building_passport_updated_at"
  end

  add_index "buildings", ["territory_id"], name: "index_buildings_on_territory_id", using: :btree

  create_table "contract_attachments", force: true do |t|
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "contract_files", force: true do |t|
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "contracts", force: true do |t|
    t.integer  "number"
    t.float    "rate"
    t.integer  "room_id"
    t.integer  "leaser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contract_project_file_name"
    t.string   "contract_project_content_type"
    t.integer  "contract_project_file_size"
    t.datetime "contract_project_updated_at"
    t.integer  "duration"
    t.date     "sign_date"
    t.integer  "status",                        default: 0
  end

  create_table "entities", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leasers", force: true do |t|
    t.string   "name"
    t.string   "contacts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.integer  "number"
    t.integer  "space"
    t.integer  "building_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "floor_plan_file_name"
    t.string   "floor_plan_content_type"
    t.integer  "floor_plan_file_size"
    t.datetime "floor_plan_updated_at"
  end

  add_index "levels", ["building_id"], name: "index_levels_on_building_id", using: :btree

  create_table "purposes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: true do |t|
    t.integer  "number"
    t.integer  "space"
    t.integer  "level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "territories", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "cad"
    t.integer  "space"
    t.string   "certificate"
    t.integer  "entity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cad_passport_file_name"
    t.string   "cad_passport_content_type"
    t.integer  "cad_passport_file_size"
    t.datetime "cad_passport_updated_at"
    t.string   "certificate_file_name"
    t.string   "certificate_content_type"
    t.integer  "certificate_file_size"
    t.datetime "certificate_updated_at"
    t.string   "passport_certificate_file_name"
    t.string   "passport_certificate_content_type"
    t.integer  "passport_certificate_file_size"
    t.datetime "passport_certificate_updated_at"
    t.string   "license_certificate_file_name"
    t.string   "license_certificate_content_type"
    t.integer  "license_certificate_file_size"
    t.datetime "license_certificate_updated_at"
  end

  add_index "territories", ["entity_id"], name: "index_territories_on_entity_id", using: :btree

end
