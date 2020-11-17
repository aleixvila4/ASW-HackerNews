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

ActiveRecord::Schema.define(version: 2020_11_17_160728) do

  create_table "comment_votes", force: :cascade do |t|
    t.string "idComment"
    t.string "idUsuari"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "commentText"
    t.integer "Contributions_id", null: false
    t.integer "Users_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "points", default: 0
    t.index ["Contributions_id"], name: "index_comments_on_Contributions_id"
    t.index ["Users_id"], name: "index_comments_on_Users_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.text "url"
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "points", default: 0
  end

  create_table "replies", force: :cascade do |t|
    t.text "replyText"
    t.integer "Comments_id", null: false
    t.integer "Users_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "points", default: 0
    t.index ["Comments_id"], name: "index_replies_on_Comments_id"
    t.index ["Users_id"], name: "index_replies_on_Users_id"
  end

  create_table "reply_votes", force: :cascade do |t|
    t.string "idReply"
    t.string "idUsuari"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.integer "Karma"
    t.string "email"
    t.text "about"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", force: :cascade do |t|
    t.string "idContrib"
    t.string "idUsuari"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "comments", "Contributions", column: "Contributions_id"
  add_foreign_key "comments", "Users", column: "Users_id"
  add_foreign_key "replies", "Comments", column: "Comments_id"
  add_foreign_key "replies", "Users", column: "Users_id"
end
