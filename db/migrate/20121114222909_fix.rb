class Fix < ActiveRecord::Migration
  def change
  	  create_table "chatboxes", :force => true do |t|
        t.datetime "created_at", :null => false
        t.datetime "updated_at", :null => false
      end
  end
end
