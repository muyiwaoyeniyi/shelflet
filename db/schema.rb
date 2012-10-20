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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121020141312) do

  create_table "book_categories", :force => true do |t|
    t.integer "category_id"
    t.integer "book_id"
  end

  add_index "book_categories", ["book_id"], :name => "index_book_categories_on_book_id"
  add_index "book_categories", ["category_id"], :name => "index_book_categories_on_category_id"

  create_table "books", :force => true do |t|
    t.string   "title",                    :default => "", :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "isbn"
    t.string   "author"
    t.string   "publisher"
    t.integer  "edition"
    t.text     "description"
    t.string   "cover_photo_file_name"
    t.string   "cover_photo_content_type"
    t.integer  "cover_photo_file_size"
    t.datetime "cover_photo_updated_at"
  end

  create_table "categories", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  create_table "conditions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_book_photos", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_book_id"
  end

  add_index "user_book_photos", ["user_book_id"], :name => "index_user_book_photos_on_user_book_id"

  create_table "user_books", :force => true do |t|
    t.decimal  "price",          :precision => 8, :scale => 2
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "book_id"
    t.integer  "user_id"
    t.text     "conditionNotes"
    t.string   "location"
    t.boolean  "duration1"
    t.boolean  "duration2"
    t.boolean  "duration3"
    t.integer  "quantity"
    t.integer  "condition_id"
  end

  add_index "user_books", ["book_id"], :name => "index_user_books_on_book_id"
  add_index "user_books", ["condition_id"], :name => "index_user_books_on_condition_id"
  add_index "user_books", ["user_id"], :name => "index_user_books_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "school_or_city"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
