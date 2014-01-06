class Event < ActiveRecord::Base
	attr_accessible :content, :end_date, :location, :public, :start_date, :title, :weeks_repeat, :end_repeat

	validates :title, :start_date, :end_date, presence: true
	validates :weeks_repeat, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
	validate :end_date_cannot_be_before_start_date

	# a < b where a and b are dates means that a is before b
	def end_date_cannot_be_before_start_date
		if end_date.present? && start_date.present? && end_date < start_date
			errors.add(:end_date, "cannot be before start date")
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
