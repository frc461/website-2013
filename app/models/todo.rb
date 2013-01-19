class Todo < ActiveRecord::Base
  attr_accessible :content, :done, :name
  belongs_to :group
end
