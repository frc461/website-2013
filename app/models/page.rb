class Page < ActiveRecord::Base
  attr_accessible :content, :navigable, :parent_id, :title, :tag_list
  validates_format_of :title, :with => /^[a-zA-Z0-9\- ]+$/

  has_many :pages, :foreign_key => :parent_id
  belongs_to :parent, :foreign_key => :parent_id, :class_name => :Page

  acts_as_taggable
end
