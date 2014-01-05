class Event < ActiveRecord::Base
	attr_accessible :content, :end_date, :location, :public, :start_date, :title, :weeks_repeat, :end_repeat

	before_save :check_for_errors

	def check_for_errors
		if self.title.length == 0
			self.errors.add(:base, "Events must have titles!")
		end

		if !self.start_date
			self.errors.add(:base, "Events must have start dates!")
		end

		if !self.end_date
			self.errors.add(:base, "Events must have end dates!")
		end

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
