class Comment < ActiveRecord::Base
  validates_presence_of :comment

  attr_protected :user_id, :commentable_id

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  belongs_to :user
end
