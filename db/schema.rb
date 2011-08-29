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

ActiveRecord::Schema.define(:version => 20110815172646) do

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "ip"
    t.integer  "port"
    t.datetime "last_checked"
    t.boolean  "last_state"
    t.boolean  "disabled"
    t.integer  "up_emails_sent"
    t.integer  "down_emails_sent"
    t.integer  "times_up"
    t.integer  "times_down"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "test_frequency"
    t.boolean  "send_emails"
    t.boolean  "send_sms"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
