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

ActiveRecord::Schema[7.2].define(version: 2024_10_09_122939) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "geo_locations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "query", null: false
    t.string "ip", null: false
    t.string "domain", null: false
    t.string "continent"
    t.string "country"
    t.string "country_code"
    t.string "region"
    t.string "region_code"
    t.string "city"
    t.string "zip"
    t.string "timezone"
    t.string "lattitude"
    t.string "longitude"
    t.string "isp_name"
    t.string "org_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_geo_locations_on_domain"
    t.index ["ip"], name: "index_geo_locations_on_ip"
    t.index ["query"], name: "index_geo_locations_on_query", unique: true
  end
end
