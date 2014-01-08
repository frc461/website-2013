class Todo < ActiveRecord::Base
	attr_accessible :content, :done, :name, :group_id

	has_many :assignments
	has_many :users, :through => :assignments

	belongs_to :group
	
	validates :name, presence: true

	acts_as_taggable
end
