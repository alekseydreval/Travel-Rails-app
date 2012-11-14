class DropMessagesTable < ActiveRecord::Migration
  def up
  	drop_table :messages

  	create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "chatbox_id"
  end

  end

  def down
  end
end
