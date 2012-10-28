class Comment < ActiveRecord::Base
  has_ancestry
  belongs_to :user

  attr_accessible :text, :commentable_id, :commentable_type, :parent_id
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

end
