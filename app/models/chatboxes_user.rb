class ChatboxesUser < ActiveRecord::Base
    attr_accessible :chatbox_id, :user_id
	belongs_to :user
	belongs_to :chatbox
end
