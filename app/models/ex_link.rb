class ExLink < ActiveRecord::Base
  attr_accessible :link, :place_id
  belongs_to :place
  validates_length_of :link, :maximum => 120#,
                      #:allow_blank => false, :message => "Shouldn't be more than 120 chars "
  validates :link, :presence => { message: "Shouldn't be blank" }
end
