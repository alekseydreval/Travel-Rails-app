class Message < ActiveRecord::Base
  attr_accessible :chatbox_id, :user_id, :text
  belongs_to :user
  belongs_to :chatbox
end
