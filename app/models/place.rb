class Place < ActiveRecord::Base
  attr_accessible :description, :coords, :name, :ex_links_attributes, :temp, :user_id
  has_many :ex_links
  has_many :pictures, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :user

  validates :description, :name, :presence => true
  validates :description, :length => {in: 10..1500}
  validates_associated :ex_links

  accepts_nested_attributes_for :ex_links, :allow_destroy => true
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  before_save :set_default_values

  def set_default_values
    self.temp ||= false
    true
  end

end