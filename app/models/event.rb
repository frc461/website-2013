class Event < ActiveRecord::Base
	attr_accessible :content, :endDate, :location, :public, :startDate, :title
	def calendarify()
		r={}
		r[:id] = self.id
		r[:start] = self.startDate.iso8601
		r[:end] = self.endDate.iso8601
		r[:title] = self.title
		r[:url] = "/events/#{id}"
		return(r)
	end
end
