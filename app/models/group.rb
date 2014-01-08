class Group < ActiveRecord::Base
	attr_accessible :name, :joinable, :page_access, :post_access, :photo_access, :event_access, :user_access, :forum_access, :group_access
	
	has_many :memberships
	has_many :users, :through => :memberships
	has_many :todos
	has_many :forums

	validates :name, presence: true
end
