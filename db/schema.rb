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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120613023713) do

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.integer  "dealer_id"
    t.integer  "corporation_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "corporations", :force => true do |t|
    t.string   "name"
    t.integer  "dealer_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dealers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "manages_roles", :id => false, :force => true do |t|
    t.integer "manage_id", :null => false
    t.integer "role_id",   :null => false
  end

  create_table "merchants", :force => true do |t|
    t.string   "name"
    t.integer  "dealer_id"
    t.integer  "corporation_id"
    t.integer  "brand_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name",             :limit => 31
    t.string   "domain_type",      :limit => 31
    t.text     "can_manage_roles"
    t.text     "permissions"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",             :limit => 20
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token", :limit => 40
    t.string   "perishable_token",                :default => "", :null => false
    t.string   "email"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

end
