class Event < ActiveRecord::Base
	attr_accessible :content, :end_date, :location, :public, :start_date, :title, :weeks_repeat, :end_repeat

	validates :title, :start_date, :end_date, presence: true

	before_save :check_for_errors

	def check_for_errors
		if self.start_date && self.end_date
			# check for start_date before end_date
		end
	end
	
	def calendarify
		r = {}
		r[:id] = self.id
		r[:start] = self.start_date.iso8601
		r[:end] = self.end_date.iso8601
		r[:title] = self.title
		r[:url] = "/events/#{id}"
		r
	end
end
