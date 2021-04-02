class AddNameToALists < ActiveRecord::Migration[5.2]
  def change
    create_table "books", force: :cascade do |t|

      t.string "title"
      t.text "body"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "user_id"
    end
  end
end
