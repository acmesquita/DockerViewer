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

ActiveRecord::Schema.define(version: 2018_09_17_213021) do

  create_table "containers", force: :cascade do |t|
    t.string "container_id"
    t.string "image"
    t.string "command"
    t.string "created"
    t.string "status"
    t.string "ports"
    t.string "names"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "server_id"
    t.index ["server_id"], name: "index_containers_on_server_id"
  end

  create_table "image_dockers", force: :cascade do |t|
    t.string "repository"
    t.string "tag"
    t.string "image_id"
    t.string "created"
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "server_id"
    t.index ["server_id"], name: "index_image_dockers_on_server_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.string "chave_ssh"
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "port"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
