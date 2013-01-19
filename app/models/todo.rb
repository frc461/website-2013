class Todo < ActiveRecord::Base
  attr_accessible :content, :done, :name
end
