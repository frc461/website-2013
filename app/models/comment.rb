class Comment < ActiveRecord::Base
  attr_accessible :content, :important, :parent_id, :sticky, :title, :user_id, :forum_id

  has_many :comments, :foreign_key => :parent_id, :class_name => :comment
  belongs_to :forum
  belongs_to :user
  belongs_to :parent, :foreign_key => :parent_id, :class_name => :Comment

  acts_as_taggable
end
