class Assignment < ActiveRecord::Base
	attr_accessible :todo_id, :user_id

	belongs_to :todo
	belongs_to :user
end
