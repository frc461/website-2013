class Forum < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :comments
  
  acts_as_taggable
end
