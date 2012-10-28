class Picture < ActiveRecord::Base
  attr_accessible :place_id, :pic
  belongs_to :place
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy 
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  def to_json
  	{ pic: { prev: self.pic.url(:medium),
             full: self.pic.url,
             id: self.id } }
  end
end
