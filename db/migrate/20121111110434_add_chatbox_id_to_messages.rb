class AddChatboxIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :chatbox_id, :integer
  end
end
