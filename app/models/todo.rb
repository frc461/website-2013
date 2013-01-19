class Todo < ActiveRecord::Base
  attr_accessible :content, :done, :name, :group_id
  belongs_to :group

  acts_as_taggable
end
