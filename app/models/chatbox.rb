class Chatbox < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :chatboxes_users, :dependent => :destroy
  has_many :users, through: :chatboxes_users
  has_many :messages, :dependent => :destroy

  #shows only user's messages
  def own_messages(user)
  	messages.where("user_id = ?", user.id)
  end

  #shows all messages excepting the user's own if possible
  def foreign_messages(user)
  	msg = messages.where("user_id != ?", user.id)
    return msg if msg.present?
    false
  end
  
  # check if there is no messages between 2 users and new chatbox should be created
  def persisted_chatbox?(user1, user2)
    !messages.where("user_id = ?", user1.id).blank? && !messages.where("user_id = ?", user2.id).blank? 
  end




end
