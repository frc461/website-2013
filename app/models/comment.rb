class Comment < ActiveRecord::Base
  attr_accessible :content, :important, :parent_id, :sticky, :title, :user_id
end
