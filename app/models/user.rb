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
  has_many :from_messages, :class_name => "Message", foreign_key: "from_user_id"
  has_many :to_messages,   :class_name => "Message", foreign_key: "to_user_id"

  def displayed_name
  	name.blank? ? email : name
  end

  def incoming_messages
  end

end
