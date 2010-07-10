# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100708182116) do

  create_table "initiatives", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.float    "completed"
    t.date     "beginning"
    t.date     "end"
    t.integer  "objective_id"
    t.integer  "initiative_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "responsible_id"
  end

  create_table "measures", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.integer  "challenge"
    t.float    "excellent"
    t.float    "alert"
    t.integer  "frecuency"
    t.date     "period_from"
    t.date     "period_to"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "responsible_id"
    t.string   "formula"
  end

  create_table "measures_objectives", :id => false, :force => true do |t|
    t.integer "objective_id"
    t.integer "measure_id"
  end

  create_table "objectives", :force => true do |t|
    t.string   "name"
    t.integer  "perspective_id"
    t.integer  "objective_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "vision"
    t.text     "goal"
    t.text     "description"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "perspectives", :force => true do |t|
    t.string   "name"
    t.integer  "strategy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privileges", :force => true do |t|
    t.integer  "module"
    t.integer  "privilege"
    t.integer  "module_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responsibles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "strategies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", :force => true do |t|
    t.float    "goal"
    t.float    "achieved"
    t.string   "period"
    t.integer  "measure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
