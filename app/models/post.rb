class Post < ActiveRecord::Base
	attr_accessible :content, :title, :user_id, :tag_list

	alias_attribute :name, :title

	acts_as_taggable
end
