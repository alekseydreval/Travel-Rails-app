class Message < ActiveRecord::Base
  attr_accessible :from_user_id, :is_read, :text, :to_user_id
  belongs_to :from_user, class_name: "User", inverse_of: :from_messages
  belongs_to :to_user, class_name: "User", inverse_of: :to_messages
end
