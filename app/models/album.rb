class Album < ActiveRecord::Base
  attr_accessible :description, :name, :tag_list

  has_many :photos

  acts_as_taggable  
end
