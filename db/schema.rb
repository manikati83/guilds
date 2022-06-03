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

ActiveRecord::Schema.define(version: 2022_06_03_094258) do

  create_table "action_text_rich_texts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "approvals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "content"
    t.index ["guild_id"], name: "index_approvals_on_guild_id"
    t.index ["user_id", "guild_id"], name: "index_approvals_on_user_id_and_guild_id", unique: true
    t.index ["user_id"], name: "index_approvals_on_user_id"
  end

  create_table "blogs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.bigint "guild_blog_tag_id"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_blog_tag_id"], name: "index_blogs_on_guild_blog_tag_id"
    t.index ["guild_id"], name: "index_blogs_on_guild_id"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "favorite_blogs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "blog_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["blog_id"], name: "index_favorite_blogs_on_blog_id"
    t.index ["user_id", "blog_id"], name: "index_favorite_blogs_on_user_id_and_blog_id", unique: true
    t.index ["user_id"], name: "index_favorite_blogs_on_user_id"
  end

  create_table "favorite_galleries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "gallery_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gallery_id"], name: "index_favorite_galleries_on_gallery_id"
    t.index ["user_id", "gallery_id"], name: "index_favorite_galleries_on_user_id_and_gallery_id", unique: true
    t.index ["user_id"], name: "index_favorite_galleries_on_user_id"
  end

  create_table "favorite_guilds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_favorite_guilds_on_guild_id"
    t.index ["user_id", "guild_id"], name: "index_favorite_guilds_on_user_id_and_guild_id", unique: true
    t.index ["user_id"], name: "index_favorite_guilds_on_user_id"
  end

  create_table "galleries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.string "photo"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_galleries_on_guild_id"
    t.index ["user_id"], name: "index_galleries_on_user_id"
  end

  create_table "guild_blog_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "guild_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_guild_blog_tags_on_guild_id"
  end

  create_table "guild_hashtag_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "guild_id", null: false
    t.bigint "hashtag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_guild_hashtag_relations_on_guild_id"
    t.index ["hashtag_id"], name: "index_guild_hashtag_relations_on_hashtag_id"
  end

  create_table "guild_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "connection", default: false
    t.index ["guild_id"], name: "index_guild_members_on_guild_id"
    t.index ["user_id", "guild_id"], name: "index_guild_members_on_user_id_and_guild_id", unique: true
    t.index ["user_id"], name: "index_guild_members_on_user_id"
  end

  create_table "guild_news", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "guild_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_guild_news_on_guild_id"
  end

  create_table "guilds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "content"
    t.string "image"
    t.boolean "guild_type"
    t.boolean "join_type"
    t.text "hashbody"
    t.integer "limit_member"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_guilds_on_user_id"
  end

  create_table "hashtags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "hashname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hashname"], name: "index_hashtags_on_hashname", unique: true
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "message"
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_messages_on_guild_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_notifications_on_guild_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "quest_members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "quest_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quest_id", "user_id"], name: "index_quest_members_on_quest_id_and_user_id", unique: true
    t.index ["quest_id"], name: "index_quest_members_on_quest_id"
    t.index ["user_id"], name: "index_quest_members_on_user_id"
  end

  create_table "quest_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "quest_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quest_id"], name: "index_quest_messages_on_quest_id"
    t.index ["user_id"], name: "index_quest_messages_on_user_id"
  end

  create_table "quests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.string "title"
    t.text "content"
    t.string "image"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_quests_on_guild_id"
    t.index ["user_id"], name: "index_quests_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "online", default: false
    t.datetime "online_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "approvals", "guilds"
  add_foreign_key "approvals", "users"
  add_foreign_key "blogs", "guild_blog_tags"
  add_foreign_key "blogs", "guilds"
  add_foreign_key "blogs", "users"
  add_foreign_key "favorite_blogs", "blogs"
  add_foreign_key "favorite_blogs", "users"
  add_foreign_key "favorite_galleries", "galleries"
  add_foreign_key "favorite_galleries", "users"
  add_foreign_key "favorite_guilds", "guilds"
  add_foreign_key "favorite_guilds", "users"
  add_foreign_key "galleries", "guilds"
  add_foreign_key "galleries", "users"
  add_foreign_key "guild_blog_tags", "guilds"
  add_foreign_key "guild_hashtag_relations", "guilds"
  add_foreign_key "guild_hashtag_relations", "hashtags"
  add_foreign_key "guild_members", "guilds"
  add_foreign_key "guild_members", "users"
  add_foreign_key "guild_news", "guilds"
  add_foreign_key "guilds", "users"
  add_foreign_key "messages", "guilds"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "guilds"
  add_foreign_key "notifications", "users"
  add_foreign_key "quest_members", "quests"
  add_foreign_key "quest_members", "users"
  add_foreign_key "quest_messages", "quests"
  add_foreign_key "quest_messages", "users"
  add_foreign_key "quests", "guilds"
  add_foreign_key "quests", "users"
end
