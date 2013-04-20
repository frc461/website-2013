class Album < ActiveRecord::Base
  attr_accessible :description, :visible, :name, :tag_list

  has_many :photos

  acts_as_taggable  
end
