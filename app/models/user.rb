class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :avatar, :password, :password_confirmation, :name
  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :small => "125x125" },
                     storage: :dropbox,
                     dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
                     dropbox_options: { unique_filename: true }

  validates_uniqueness_of :email
  validates :name, :email, :password, :password_confirmation, :presence => true
  validates_length_of :password, minimum: 6
  validates_length_of :name, minimum: 4

  has_many :places
  has_many :pictures
  has_many :comments

  has_many :chatboxes_user, dependent: :destroy
  has_many :chatboxes, through: :chatboxes_user, dependent: :destroy
  has_many :messages, dependent: :destroy

  def displayed_name
  	name.blank? ? email : name
  end

  def get_avatar
    avatar(:small) rescue Rails.root.join('public', 'images', 'default_avatar.jpg')
  end

  # check if there is a messages between 2 users and create new chatbox if needed
  def find_or_create_chatbox(another_user)
    cb = chatboxes.select{|c| c.messages.where("user_id = ?", self.id).present? && c.messages.where("user_id = ?", another_user.id).present? }.first
    if cb.blank?
      cb = chatboxes.create
      cb.users << another_user
    end
    cb
  end

  def income_messages
    msgs = []
    chatboxes.each do |c|
      msgs << c.messages.select{|msg| msg.user != self }
    end
    msgs.flatten
  end

end
