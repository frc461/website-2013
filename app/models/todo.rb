class Todo < ActiveRecord::Base
	attr_accessible :content, :done, :name, :group_id
	validates_presence_of :name

	belongs_to :group

	has_many :assignments
	has_many :users, :through => :assignments

	acts_as_taggable
end
