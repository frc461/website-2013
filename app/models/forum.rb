class Forum < ActiveRecord::Base
	attr_accessible :description, :name, :group_id

	has_many :comments

	belongs_to :group 

	acts_as_taggable
end
