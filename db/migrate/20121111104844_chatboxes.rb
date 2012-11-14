class Chatboxes < ActiveRecord::Migration
  def change
    create_table :chatboxes_user do |t|
      t.integer "user_id"
      t.integer "chatbox_id"
      t.timestamps
    end
  end

end
