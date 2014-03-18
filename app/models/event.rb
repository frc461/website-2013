class Event < ActiveRecord::Base
	attr_accessible :content, :end_date, :location, :public, :start_date, :title, :weeks_repeat, :end_repeat, :color, :showtime

	# Require title, start_date, and :end_date to be things.
	validates :title, :start_date, :end_date, presence: true

	# Require weeks_repeat to be only an integer that is greater than or equal to 0 (or blank)
	validates :weeks_repeat, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true

	# Require end date to come after start date
	validate :end_date_cannot_be_before_start_date

	# a < b where a and b are dates means that a is before b
	def end_date_cannot_be_before_start_date
		if start_date.present? && end_date.present? && end_date < start_date
			errors.add(:end_date, "cannot be before start date")
		end
	end

	# Convert this into a cute hash thing for fullcalendar.
	def calendarify
		r = {}

		r[:id] = id
		r[:start] = start_date.iso8601
		r[:end] = end_date.iso8601
		r[:title] = title + (showtime ? "\n#{start_date.strftime "%l:%M %p"} - #{end_date.strftime "%l:%M %p"}" : "")
		r[:url] = "/events/#{id}"
		r[:color] = color

		r
	end
end
