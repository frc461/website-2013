class Event < ActiveRecord::Base
	attr_accessible :content, :end_date, :location, :public, :start_date, :title, :weeks_repeat, :end_repeat
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
