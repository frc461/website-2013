class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :tag_list

  acts_as_taggable
end
