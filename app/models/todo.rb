class Todo < ActiveRecord::Base
  attr_accessible :content, :done, :name

  acts_as_taggable
end
