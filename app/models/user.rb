class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :name
  validates_uniqueness_of :email
  validates :name, :email, :password, :password_confirmation, :presence => true
  validates_length_of :password, minimum: 6
  validates_length_of :name, minimum: 4


  has_many :places
  has_many :pictures
  has_many :comments

  def displayed_name
  	name.blank? ? email : name
  end

end
