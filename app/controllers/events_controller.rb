class EventsController < InheritedResources::Base
	require 'icalendar'
	# include Icaldendar
	load_and_authorize_resource
	def icalendarify
		cal = Icalendar::Calendar.new # icalendar
		@events.each do |ev|
			cal.event do
				dtstart     ev.startDate
				dtend       ev.endDate
				summary     ev.title
				description ev.content
			end
		end
		cal.to_ical
	end
	
	def index
		if current_user
			@events = Event.all
			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: @events.map{|a| a.calendarify()} }
				format.ics { render text: icalendarify }
			end
		else
			@events = Event.where(:public => true)
			respond_to do |format|
				format.html # index.html.erb
				format.json { render json: @events.map{|a| a.calendarify()} }
				format.ics { render text: icalendarify }
			end
		end
	end
end
