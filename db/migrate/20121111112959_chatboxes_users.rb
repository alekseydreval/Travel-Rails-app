class ChatboxesUsers < ActiveRecord::Migration
  def change
  create_table "chatboxes_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "chatbox_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  end
end
